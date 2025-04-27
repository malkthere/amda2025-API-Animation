import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBarView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      print('Selected Tab Index: ${_tabController.index}');
      // You can perform actions based on the selected tab here
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBarView Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(text: 'Music'),
            Tab(icon: Icon(Icons.movie)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: Text(
              'Car Tab Content',
              style: TextStyle(fontSize: 24),
            ),
          ),
           Column(
             children: [
               ExpansionTile(
                  title: Text('Settings'),
                  children: [
                    ListTile(title: Text('Theme')),
                    ListTile(title: Text('Notifications')),
                    ListTile(title: Text('Privacy')),
                  ],
                ),
               ExpansionTile(
                  title: Text('prefrences'),
                  children: [
                    ListTile(title: Text('food')),
                    ListTile(title: Text('storts')),
                    ListTile(title: Text('Privacy')),
                  ],
                ),
             ],
           ),
          Center(
            child: Text(
              'Movie Tab Content',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}