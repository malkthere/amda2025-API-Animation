import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpansionTile Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpansionTile with onExpansionChanged'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ExpansionTile(
              title: const Text('Tile 1'),
              subtitle: Text('Expanded: $_isExpanded1'),
              initiallyExpanded: _isExpanded1,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded1 = expanded;
                  print('Tile 1 expanded: $expanded');
                  // You can perform other actions here when the tile expands/collapses
                });
              },
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'This is the content of the first expansion tile. '
                        'You can put any widgets you like here.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ExpansionTile(
              title: const Text('Tile 2'),
              subtitle: Text('Expanded: $_isExpanded2'),
              initiallyExpanded: _isExpanded2,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded2 = expanded;
                  print('Tile 2 expanded: $expanded');
                  // Perform different actions for the second tile
                  if (expanded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tile 2 is now expanded!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tile 2 is now collapsed.')),
                    );
                  }
                });
              },
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Item A'),
                  onTap: () {
                    print('Item A tapped in Tile 2');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text('Item B'),
                  onTap: () {
                    print('Item B tapped in Tile 2');
                  },
                ),
              ],
            ),
            // You can add more ExpansionTile widgets here
          ],
        ),
      ),
    );
  }
}