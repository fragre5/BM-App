import 'package:flutter/material.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {

  final String clientInfo;

  const LoginPage({Key? key, required this.clientInfo}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(clientInfo: clientInfo);
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String clientInfo;
  List<dynamic>? beautyTags;
  String? name;
  String? surname;
  String? email;
  String? phone;
  String? birthday;

  _LoginPageState({required this.clientInfo}) {
    final Map<String, dynamic> jsonData = json.decode(clientInfo);

    if(jsonData.containsKey('client') && jsonData['client'] is Map<String, dynamic>) {

      final Map<String, dynamic> clientData = jsonData['client'];

      //beautyTags = clientData['beatyTags'];
      name = clientData['name'];
      surname = clientData['surname'];
      email = clientData['email'];
      phone = clientData['phone'];
      birthday = clientData['birthday'];

    }


  }

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
               Text(
                "Имя: $name",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Фамилия: $surname",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
               Text(
                "Почта: $email",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
               Text(
                "Телефон: $phone",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Дата рождения:${birthday?.substring(0, 10)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ваши предпочтения:$beautyTags",
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