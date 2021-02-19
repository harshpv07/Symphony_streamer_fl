import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'new_element.dart';
import 'package:http/http.dart' as http;

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String resp_mess = "";
  final items = [];
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
    //print("response body -> " + "${response.body}");
    Map tc = json.decode(response.body);
    setState(() {
      resp_mess = response.body;
    });
    print(tc);
    tc.forEach((k, v) => items.add(k));

    return response;
  }

  @override
  void initState() {
    postRequest("http://192.168.29.143:5000/return_store_values", {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Add Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(title),
          actions: [
            FloatingActionButton(
              onPressed: () {
                print("pressed");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => New_ele()));
              },
              child: Icon(Icons.add),
              elevation: 0.0,
              disabledElevation: 0.0,
              backgroundColor: Colors.red,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                print(item);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(title: Text('$item')),
            );
          },
        ),
      ),
    );
  }
}
