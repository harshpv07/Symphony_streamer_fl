import 'package:flutter/material.dart';

class Primary extends StatefulWidget {
  @override
  PrimaryState createState() => PrimaryState();
}

class PrimaryState extends State<Primary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("this is the primary page"),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
