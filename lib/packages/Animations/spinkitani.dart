import "dart:convert";
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class spinkt extends StatefulWidget {
  @override
  _spinktState createState() => _spinktState();
}

class _spinktState extends State<spinkt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
