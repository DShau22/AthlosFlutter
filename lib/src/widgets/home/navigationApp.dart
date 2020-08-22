import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:AthlosFlutter/src/models/userDataModel.dart';
import 'package:AthlosFlutter/src/models/localFitnessModel.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitness.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataModel>(create: (context) => UserDataModel()),
        // ChangeNotifierProvider<FitnessModel>(create: (context) => FitnessModel()),
      ],
      child: Scaffold(
        bottomNavigationBar: Material(
          child: TabBar(
            tabs: <Tab> [
              Tab(icon: Icon(Icons.fitness_center), text: 'fitness',),
              Tab(icon: Icon(Icons.device_hub), text: 'config'),
            ],
            controller: _controller,
          ),
          color: Colors.blue,
        ),
        // this is where each screen goes
        body: TabBarView(
          children: <Widget>[
            // fitness
            Consumer<UserDataModel>(
              builder: (context, userDataModel, child) => Fitness(userDataModel)
            ),
            // config
            Consumer<UserDataModel>(
              builder: (context, userDataModel, child) => Container(
                color: Colors.orange,
                alignment: Alignment.center,
                child: Text('config tab!')
              )
            )
          ],
          controller: _controller,
        )
      ),
    );
  }
}
