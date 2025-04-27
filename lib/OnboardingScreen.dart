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
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Chats'),
                Tab(text: 'Status'),
                Tab(text: 'Calls'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Chats Screen')),
                  Center(child: Text('Status Screen')),
                  Center(child: Text('Calls Screen')),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
