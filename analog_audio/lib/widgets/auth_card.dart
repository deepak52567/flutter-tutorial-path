import 'package:analog_audio/models/enums.dart';
import 'package:analog_audio/models/http_exception.dart';
import 'package:analog_audio/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_mode_toggle.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confPassFocusNode = FocusNode();

  var _isLoading = false;

  AuthMode? _authMode = AuthMode.Login;

  @override
  void dispose() {
    _confPassFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  void toggleAuthState() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) {
      // Invalid!
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else if (_authMode == AuthMode.Signup) {
        await Provider.of<Auth>(context, listen: false)
            .singUp(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (err) {
      print(err);
      var errorMessage = 'Authentication Failed';
      if (err.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already exists';
      } else if (err.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email address';
      } else if (err.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password is too weak';
      } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not found a user with that email';
      } else if (err.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      _showErrorDialog(errorMessage);
    } catch (err) {
      var errorMessage = 'Couldn\'t authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Invalid Email';
                }
                return null;
              },
              onSaved: (newValue) {
                _authData['email'] = newValue!;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              textInputAction: _authMode == AuthMode.Signup
                  ? TextInputAction.next
                  : TextInputAction.done,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password),
              ),
              obscureText: true,
              controller: _passwordController,
              onFieldSubmitted: (value) {
                _authMode == AuthMode.Signup
                    ? FocusScope.of(context).requestFocus(_confPassFocusNode)
                    : null;
              },
              validator: (value) {
                if (value!.isEmpty || value.length < 5) {
                  return 'Password is too short';
                }
                return null;
              },
              onSaved: (newValue) {
                _authData['password'] = newValue!;
              },
            ),
            SizedBox(
              height: _authMode == AuthMode.Signup ? 10 : 0,
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                textInputAction: TextInputAction.send,
                focusNode: _confPassFocusNode,
                enabled: _authMode == AuthMode.Signup,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.password),
                ),
                obscureText: true,
                validator: _authMode == AuthMode.Signup
                    ? (value) {
                        if (value != _passwordController.text) {
                          return 'Password doesn\'t match!';
                        }
                      }
                    : null,
                onSaved: (newValue) {
                  _authData['password'] = newValue!;
                },
              ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                  child: _isLoading
                      ? Container(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(_authMode == AuthMode.Login ? 'Login' : 'Sign Up'),
                  onPressed: _isLoading ? null : _submit,
                  style: Theme.of(context).elevatedButtonTheme.style),
            ),
            AuthModeToggle(_authMode!, toggleAuthState),
          ],
        ),
      ),
    );
  }
}
