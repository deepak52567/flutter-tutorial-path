import 'dart:math';

import 'package:apparel/models/http_exception.dart';
import 'package:apparel/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // .. operator calls translate on an object and return
                      // To avoid it, we can also a transform config used above on dec
                      // what previous statement returned
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline6!
                              .color,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  // late Animation<Size> _heightAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // set initial state of animation and assign widget which is going
    // to be animate
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));
    // Will be using in AnimatedContainer
    // _heightAnimation = Tween<Size>(
    //   begin: Size(double.infinity, 260),
    //   end: Size(double.infinity, 320),
    // ).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeIn,
    // ));
    // Updating state
    // Dont use when using in-built widget animation
    // _heightAnimation.addListener(() => setState(() {}));

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween(
      begin: Offset(0, -0.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).singIn(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on HttpException catch (err) {
      // Filtering the thrown error from provider to filter out the authentication failure
      // exception
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
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      // Also we can use AnimatedBuilder to build and run animation
      // by passing up the _heightAnimation controller here
      // AnimatedBuilder(
      //   animation: _heightAnimation,
      //   builder: (context, noAniChild) => Container(
      //     // height: _authMode == AuthMode.Signup ? 320 : 260,
      //     height: _heightAnimation.value.height,
      //     constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
      //     width: deviceSize.width * 0.75,
      //     padding: EdgeInsets.all(16.0),
      //     child: noAniChild,
      //   ),
      // child: Pass child here that done need be rebuild
      // or animate
      // )

      child: AnimatedContainer(
        // Need AnimatedBuilder method
        // height: _heightAnimation.value.height,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                // Instead of this we will be using FadeTransition
                // if (_authMode == AuthMode.Signup)
                // Created AnimatedContainer to shrink container size of
                // input widget
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  // Hides input field on toggle
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    // Slider input box up-down
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        // TO hide password
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryTextTheme.button!.color,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
