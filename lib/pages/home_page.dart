import 'package:flutter/material.dart';

import 'package:marketapp/pages/registration_page.dart';
import 'package:marketapp/pages/login_page.dart';
import 'package:marketapp/requests/requests.dart';

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
      home: const HomePage(
          title: 'Beauty Market',
      ),
    );
  }
}

class _MyHomePageState extends State<HomePage> {
  final _emailFieldKey = GlobalKey<FormState>();
  String _userEmail = '';

  void _openRegistrationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }

  void _openLoginPage(String clientInfo) {
    if (_emailFieldKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage(clientInfo: clientInfo)),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Form(
                key: _emailFieldKey,
                child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Введите почту',
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Поле с вашей почтой - пусто!';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _userEmail = value;
                  });
                },
              ),
             ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: ElevatedButton(
                    onPressed: () async {
                      if(_emailFieldKey.currentState!.validate()) {
                        bool authorized = await authorizeClient(_userEmail);

                        if (authorized) {
                          String clientInfo = await showOTPDialog(context, _userEmail);
                          _openLoginPage(clientInfo);
                        }
                      }
                    },
                    child: const Text('Войти')
                )
            ),
            const Padding(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text (
                  "Нет аккаунта? Создайте его прямо сейчас!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _openRegistrationPage,
                child: const Text('Регистрация'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
