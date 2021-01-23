import 'package:flutter/material.dart';
import 'packages/landing_page.dart';
import 'packages/primary_page.dart';
import 'packages/login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/main': (context) => Primary(),
      '/landing': (context) => Landing(),
    },
  ));
}
