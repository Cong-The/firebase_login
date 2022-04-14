import 'package:flutter/material.dart';
import 'package:login_firebase/shared/constants.dart';
import 'package:login_firebase/shared/loading.dart';
import '../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: const Text('sign in to App'),
              actions: <Widget>[
                TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Register'))
              ],
            ),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration:
                                TextInputDecoration.copyWith(hintText: 'Email'),
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: TextInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (String? value) {
                              if (value!.length < 6) {
                                return "Enter a password 6+ chars long";
                              }
                              return null;
                            },
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error =
                                          'cloud not sign in with those cedentials';
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink[400], // background
                                onPrimary:
                                    Colors.white, // foreground // mau chu
                              ),
                              child: const Text(
                                'Sign in',
                                // style: TextStyle(color: Colors.white),
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
                        ],
                      ),
                    ))));
  }
}
