import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Animations/spinkitani.dart';

import 'landing_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          title: Text(
            "Symphony",
            style: (GoogleFonts.sacramento(fontSize: 30, color: Colors.white)),
          )),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey[900],
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                  autocorrect: true,
                  onChanged: (value) {
                    setState(() {
                      print("hey");
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                  onChanged: (value) {
                    print("hey");
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
