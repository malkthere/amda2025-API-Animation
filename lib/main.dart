import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Animations',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimationHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimationHomePage extends StatefulWidget {
  @override
  _AnimationHomePageState createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage>
    with SingleTickerProviderStateMixin {
  bool _expanded = true;
  double _opacity = 1.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  var count=0;
  @override
  void initState() {
    super.initState();
         _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 300.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
    });
  }

  void _startManualAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isRed=false;

    var _listKey;
    var items=["1","2","3","4"];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tabbed App"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.star), text: "Favorites"),
              Tab(icon: Icon(Icons.settings), text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: DataTable(
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
            ),
            Center(child: PageView(
              children: [
                Container(color: Colors.red),
                Container(child: DataTable(
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
                )),
                Container(child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(6, (index) {
                    return Card(
                      child: Center(child: Text('Item $index')),
                    );
                  }),
                ),),
              ],
            )),
            Center(child: PageView(
              children:[
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          color: value==0 ? Colors.red : Colors.blue,
                          width: value==0 ? 100 : 200,
                          height: 100,
                        ),
                      );
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    '$count=0',
                    key: ValueKey<int>(count),
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                AnimatedList(
                  key: _listKey,
                  initialItemCount: items.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      child: ListTile(title: Text(items[index]),onTap: (){},),
                    );
                  },
                )

    ]

            )),
          ],
        ),
      ),
    )
    ;
  }
}
