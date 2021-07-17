import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(child: Image.asset('assets/images/dji_logo.png')),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Analog Audio',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                width: deviceSize.width > 600
                    ? deviceSize.width * 0.2
                    : deviceSize.width * 0.25,
              ),
            ),
            Flexible(
              flex: 0,
              child: AuthCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _form = GlobalKey();
  AuthMode _authMode = AuthMode.Signup;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                filled: true,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
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
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password)),
              obscureText: true,
              controller: _passwordController,
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
              height: 20,
            ),
            TextFormField(
              enabled: _authMode == AuthMode.Signup,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  filled: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password)),
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
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Send'),
                  onPressed: () {},
                  style: Theme.of(context).elevatedButtonTheme.style),
            ),
          ],
        ),
      ),
    );
  }
}
