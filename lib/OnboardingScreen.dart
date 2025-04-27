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
      body: Center(child: Row(children: [
      Draggable<String>(
      data: 'Drag me!',
        feedback: Material(child: Text('Dragging...', style: TextStyle(fontSize: 18))),
        child: Text('Drag Me'),
      ),

        DragTarget<String>(
          onAcceptWithDetails: (data) => print('Dropped: $data'),
          builder: (ctx, _, __) => Container(
            width: 100, height: 100,
            color: Colors.grey,
            child: Center(child: Text('Drop Here')),
          ),

        ) ],),),

    );
  }
}
