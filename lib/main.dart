import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApiService {
  static Future<String> postData(String data) async {
    final apiUrl =
        'http://192.168.10.96:64077/v1/EContract/GetContracts'; // Replace with your API endpoint URL
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'FCDFCE12079C3A25E0553A63BB4403F432303233303533303039303535333738303536383830313032303533',
      },
      body: jsonEncode(<String, String>{
        'data': data,
      }),
    );

    if (response.statusCode == 200) {
      // Request was successful
      return response.body;
    } else {
      // Request failed
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _postDataToApi() async {
    try {
      final response = await MyApiService.postData('Your data goes here');
      // Handle the response from the API
      print(response);
    } catch (e) {
      // Handle any errors that occurred during the API request
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your code...

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          _postDataToApi();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
