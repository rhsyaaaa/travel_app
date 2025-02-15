// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, camel_case_types

import 'dart:convert'; // Add this import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routing/app_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class prossesAuth {
  var url = dotenv.env['baseUrl'];

  Future register(BuildContext context, String name, String email,
      String password, String confirmPassword) async {
    Uri urlRegister = Uri.parse("$url/auth/register");
    print(name);
    print(email);
    print(password);
    print(confirmPassword);
    var response = await http.post(urlRegister,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        }));
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      print("Berhasil");
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Successful"),
            content: Text("Silahkan cek email anda"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); 

                  context.goNamed(Routes.otp_verifikasi, extra: email);
                },
              ),
            ],
          );
        },
      );
    } else {
      print("gagal");
      print(response.body);
      return false;
    }
  }

  Future verifyOTP(BuildContext context, String email, String otp) async {
    Uri urlVerifyOTP = Uri.parse("$url/auth/verify");
    var response = await http.post(urlVerifyOTP, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      'email': email,
      'otp': otp,
    }));
    
    print(response.statusCode);
    if (response.statusCode == 200) {
      return context.goNamed(Routes.notif_success);
    } else {

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("kode OTP salah"),
        ),
      );
    }
  }

  Future login(BuildContext context, String email, String password) async {
    Uri urlLogin = Uri.parse("$url/auth/login");
    var response = await http.post(urlLogin, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      'email': email,
      'password': password,
    }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('berhasil');
      return context.goNamed(Routes.home);
    } else {
      print('gagal');
      print(response.body);
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email atau Password salah"),
        ),
      );
    }
  }

  Future forgotPassword(BuildContext context, String email) async {
    Uri urlForgotPassword = Uri.parse("$url/auth/forgot-password");
    var response = await http.post(urlForgotPassword, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      'email': email,
    }));
    print(response.statusCode);
    print("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Reset"),
            content: Text("A new password has been sent to your email."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  context.goNamed(Routes.notif_success_forgot_password);
                },
              ),
            ],
          );
        },
      );
    } else {
      print("Failed to reset password: ${response.body}");
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email tidak terdaftar"),
        ),
      );
    }
  }
}