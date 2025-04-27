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
      body: PageView(
        children: [
          Container(color: Colors.red, child: Center(child: Text('Page 1'))),
          Container(color: Colors.blue, child: Center(child: Text('Page 2'))),
          Container(color: Colors.green, child: Center(child: Text('Page 3'))),
        ],
      )

    );
  }
}
