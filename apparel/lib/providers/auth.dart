import 'dart:convert';

import 'package:apparel/models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  static const LOGIN_URL_SEGMENT = 'signInWithPassword';
  static const SINGUP_URL_SEGMENT = 'signUp';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCdS_oUGOnyXXhay-1Ypsl5vvMPSJmnqr8');
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
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, SINGUP_URL_SEGMENT);
  }

  Future<void> singIn(String email, String password) async {
    return _authenticate(email, password, LOGIN_URL_SEGMENT);
  }
}
