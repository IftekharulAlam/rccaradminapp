// ignore_for_file: sort_child_properties_last,, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("RC Car Admin ")),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Future writeStatus(String deviceID, String status) async {
    http.Response response = await http.post(
        Uri.parse("http://192.168.0.100:8000/writeStatus"),
        body: {"status": status, "deviceID": deviceID});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }
  Future updateStatus(String deviceID, String status) async {
    http.Response response = await http.post(
        Uri.parse("http://192.168.0.100:8000/updateStatus"),
        body: {"status": status, "deviceID": deviceID});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error loading data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Enable'),
              onPressed: () {
                //  login();
                writeStatus("1", "Enable");
              },
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Disable'),
              onPressed: () {
                //  login();
                updateStatus("1", "Disable");
              },
            ),
          ),
        ],
      ),
    );
  }
}
