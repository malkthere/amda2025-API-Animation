import 'package:flutter/material.dart';

import 'OnboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable and DragTarget Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  advancelayout(),
    );
  }
}

class DragAndDropDemo extends StatefulWidget {
  const DragAndDropDemo({super.key});

  @override
  State<DragAndDropDemo> createState() => _DragAndDropDemoState();
}

class _DragAndDropDemoState extends State<DragAndDropDemo> {
  Color _targetColor = Colors.grey[300]!;
  String _draggedData = 'Initial Data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable and DragTarget Example'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Draggable<String>(
              data: _draggedData,
              feedback: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue.withOpacity(0.7),
                child: Text(
                  _draggedData,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              childWhenDragging: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue[100],
                child: Text(
                  _draggedData,
                  style: const TextStyle(color: Colors.blueGrey),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue,
                child: Text(
                  _draggedData,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            DragTarget<String>(
              builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                  ) {
                return Container(
                  width: 200.0,
                  height: 100.0,
                  color: _targetColor,
                  child: Center(
                    child: Text(
                      accepted.isEmpty
                          ? 'Drag Here'
                          : 'Data Accepted: ${accepted.first}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              onWillAccept: (data) {
                print('onWillAccept: $data');
                return true; // Return true if you want to accept the data
              },
              onAccept: (data) {
                setState(() {
                  _draggedData = 'New Data from Target';
                  _targetColor = Colors.green[300]!;
                });
                print('onAccept: $data');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"$data" accepted!')),
                );
              },
              onLeave: (data) {
                print('onLeave: $data');
                setState(() {
                  _targetColor = Colors.grey[300]!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}