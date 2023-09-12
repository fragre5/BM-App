import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> authorizeClient(String email) async {
  final response = await http.get(Uri.parse(
      "http://10.0.2.2:8080/api/client/auth/authenticate?email=$email"));

  if (response.statusCode == HttpStatus.ok) {
    return true;
  } else {
    return false;
  }
}

Future<String> validateOTP(int otpNum, String email) async {
  final response = await http.get(Uri.parse(
      "http://10.0.2.2:8080/api/client/auth/validate?otpNum=$otpNum&email=$email"));

  if (response.statusCode == HttpStatus.ok) {
    return response.body;
  } else {
    return "неудачный запрос";
  }
}

Future<String> showOTPDialog(BuildContext context, String email) async {
  String otp = await showDialog(
    context: context,
    builder: (BuildContext context) {
      String enteredOTP = '';
      return AlertDialog(
        title: const Text('Введите код OTP'),
        content: TextField(
          onChanged: (value) {
            enteredOTP = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(enteredOTP);
            },
            child: const Text('Отправить'),
          ),
        ],
      );
    },
  );

  if (otp.isNotEmpty) {
    return await validateOTP(int.parse(otp), email);
  }

  return "Пусто";
}
