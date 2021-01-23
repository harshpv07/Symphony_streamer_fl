import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'landing_page.dart';

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
        actions: [],
        title: Text("Login Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Enter username"),
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
            ),
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
          RaisedButton(
            onPressed: () async {
              // print(username);
              // print(password);
              Map dataa = {
                "username": username,
                "password": password,
              };
              await postRequest("http://192.168.43.177:5000/login", dataa);
              if (resp_mess == "true") {
                print("username verified");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Landing()));
              }
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
