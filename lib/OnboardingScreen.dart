import 'package:flutter/material.dart';

class advancelayout extends StatefulWidget {
  @override
  _advancelayoutState createState() => _advancelayoutState();
}

class _advancelayoutState extends State<advancelayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => print('Tapped!'),
        onDoubleTap: () => print('Double Tapped!'),
        onPanUpdate: (details) => print('Dragged: ${details.delta}'),
        child: Container(width: 200, height: 200, color: Colors.blue),
      )

    );
  }
}
