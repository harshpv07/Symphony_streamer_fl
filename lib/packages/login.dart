import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Animations/spinkitani.dart';

import 'landing_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  String username = "";
  String password = "";
  String resp_mess = "";
  @override
  Widget build(BuildContext context) {
    //used for POST request to the flask server
    Future<http.Response> postRequest(String urll, Map jsonmap) async {
      setState(() {
        resp_mess = "";
      });
      var url = urll;

      Map data = jsonmap;
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print("status code ->" + "${response.statusCode}");
      print("response body -> " + "${response.body}");
      setState(() {
        resp_mess = response.body;
      });
      return response;
    }

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
          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
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
                      username = value;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    spinkt(),
                    RaisedButton(
                      color: Colors.grey[900],
                      onPressed: () async {
                        // print(username);
                        // print(password);
                        Map dataa = {
                          "username": username,
                          "password": password,
                        };
                        await postRequest(
                            "http://192.168.29.143:5000/login", dataa);

                        if (resp_mess == "true") {
                          print("username verified");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Landing()));
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Incorrect Username or passord. Try again !!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.grey[900],
                      onPressed: () async {
                        // print(username);
                        // print(password);

                        Map dataa = {
                          "username": username,
                          "password": password,
                        };
                        await postRequest(
                            "http://192.168.29.143:5000/signup", dataa);
                        if (resp_mess == "true") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Landing()));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Username exists",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
