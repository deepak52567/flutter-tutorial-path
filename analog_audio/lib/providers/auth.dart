import 'dart:async';
import 'dart:convert';

import 'package:analog_audio/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  static const AUTH_WEB_API_KEY = 'AIzaSyCDMGBSysdt5DhpF5hir5Vk6C2rKb0R8vM';

  static const LOGIN_URL_SEGMENT = 'signInWithPassword';
  static const SINGUP_URL_SEGMENT = 'signUp';

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$AUTH_WEB_API_KEY');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      initAutoLogout();
      notifyListeners();

      // Device shared preferences
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      // Setting device preferences
      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, LOGIN_URL_SEGMENT);
  }

  Future<void> singUp(String email, String password) async {
    return _authenticate(email, password, SINGUP_URL_SEGMENT);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedData = json.decode(prefs.getString('userData')!) as Map;

    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedData['token'] as String;
    _userId = extractedData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    initAutoLogout();
    return true;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void initAutoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
