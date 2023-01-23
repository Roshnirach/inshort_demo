import 'package:flutter/material.dart';
import 'package:inshorts_app/Pages/news_feed.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  String selectedCategory = 'national';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Text('Welcome back !',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Lottie.asset('assets/news.json',
                        height: screenHeight * 0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                    child: TextFormField(
                      key: const Key('emailTextField'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                    child: TextFormField(
                      key: const Key('passwordTextField'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      key: const Key('loginButton'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsFeed()));
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
