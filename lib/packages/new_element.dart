import "dart:convert";
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class New_ele extends StatefulWidget {
  @override
  _New_eleState createState() => _New_eleState();
}

class _New_eleState extends State<New_ele> {
  DateTime selectedDate = DateTime.now();
  Map store_response_data;
  String _hour, _minute, _time;
  String dateTime;
  String reminder_message = "";
  TextEditingController _timeController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  String resp_mess = "";
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
    setState(() {
      resp_mess = response.body;
      store_response_data = json.decode(response.body);
    });
    return response;
  }

  Future<Null> set_datetime(
      String hrs, String mins, String datee, String mess) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text("Add new element"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Remainder",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
              autocorrect: true,
              onChanged: (value) {
                setState(() {
                  reminder_message = value;
                });
              },
            ),
            RaisedButton(
                onPressed: () async {
                  await _selectDate(context);
                  // print(selectedDate);
                },
                child: Text("Select Date")),
            RaisedButton(
                onPressed: () async {
                  await _selectTime(context);
                  // print(_hour);
                  // print(_minute);
                },
                child: Text("Select Time")),
            RaisedButton(
                onPressed: () async {
                  String q = selectedDate.toString();
                  Map sendd = {
                    "message": reminder_message,
                    "hrs": _hour,
                    "mins": _minute,
                    "time": q.split(" ")[0]
                  };
                  // print(_hour);
                  // print(_minute);
                  // print(reminder_message);
                  await postRequest("http://192.168.29.143:5000/lists", sendd);
                  print(store_response_data);
                  // setState(() {
                  //   reminder_message = "";
                  //   _hour = "";
                  //   _minute = "";
                  //   selectedDate = null;
                  // });
                },
                child: Text("Click here to add"))
          ],
        ));
  }
}
