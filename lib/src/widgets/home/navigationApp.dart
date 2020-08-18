import 'package:flutter/material.dart';

class NavigationApp extends StatefulWidget {
  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override void initState() {
    // TODO: implement initState
    super.initState();
     _controller = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        child: TabBar(
          tabs: <Tab> [
            Tab(icon: Icon(Icons.person),),
            Tab(icon: Icon(Icons.email),),
          ],
          controller: _controller,
        ),
        color: Colors.blue,
      ),
      body: TabBarView(
        children: <Widget> [
          Container(
            color: Colors.orange,
            alignment: Alignment.center,
            child: Text('first tab!')
          ),
          Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text('second tab!')
          )
        ],
        controller: _controller,
      )
    );
  }
}
