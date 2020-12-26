import 'package:flutter/material.dart';
import 'packages/landing_page.dart';
import 'packages/primary_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Landing(),
      '/main': (context) => Primary(),
    },
  ));
}
