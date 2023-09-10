import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  final String userEmail;

  const LoginPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(userEmail: userEmail);
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String userEmail;

  _LoginPageState({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                "Ваше имя:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ваша почта: $userEmail",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}