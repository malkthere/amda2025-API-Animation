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
      body: ExpansionTile(
        title: Text("Click to expand"),
        children: [
          ListTile(title: Text("Item 1"), trailing:Icon(Icons.ice_skating), onTap: (){   },),
          ListTile(title: Text("Item 2"),trailing:Icon(Icons.museum)),

        ],

      ),
    );
  }
}
