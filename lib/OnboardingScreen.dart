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
      body: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Age')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('John')),
            DataCell(Text('25')),
          ]),
          DataRow(cells: [
            DataCell(Text('Jane')),
            DataCell(Text('30')),
          ]),
        ],
      )

    );
  }
}
