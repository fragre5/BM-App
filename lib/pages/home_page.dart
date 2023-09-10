import 'package:flutter/material.dart';

import 'package:marketapp/pages/registration_page.dart';
import 'package:marketapp/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Beauty Market'),
    );
  }
}

class _MyHomePageState extends State<HomePage> {

  final _emailFieldKey = GlobalKey<FormState>();
  String _userEmail = '';

  void _openRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const RegistrationPage()
      ),
    );
  }

  void _openLoginPage(String email) {
    if(_emailFieldKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(userEmail: email)
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _emailFieldKey,
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Введите почту'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле с вашей почтой - пусто!';
                  }
                  return null;
                },
                onChanged: (value) {
                    _userEmail = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _openRegistrationPage,
                child: const Text('Регистрация'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _openLoginPage(_userEmail);
                },
                child: const Text('Войти')
            )
          ],
        ),
      ),
    );
  }
}
