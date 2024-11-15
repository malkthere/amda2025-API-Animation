import 'package:flutter/material.dart';
import 'api_service.dart';


void main() {
  runApp(MyApiPage());
}
class MyApiPage extends StatefulWidget {
  @override
  _MyApiPageState createState() => _MyApiPageState();
}

class _MyApiPageState extends State<MyApiPage> {
  final ApiService apiService = ApiService();
  String message = '';

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  Future<void> fetchMessage() async {
    try {
      final response = await apiService.getMessage();
      setState(() {
        message = response;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('API Example')),
        body: Center(
          child: Text(
            message.isNotEmpty ? message : 'Loading...',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}