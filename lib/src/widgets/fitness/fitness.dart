import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:AthlosFlutter/src/models/localFitnessModel.dart';
import 'package:AthlosFlutter/src/widgets/fitness/screens/run.dart';
import 'package:AthlosFlutter/src/widgets/fitness/screens/swim.dart';
import 'package:AthlosFlutter/src/widgets/fitness/screens/jump.dart';
import 'package:AthlosFlutter/src/widgets/fitness/fitnessConstants.dart';

class Fitness extends StatefulWidget {
  dynamic userDataModel;
  Future runJsonFuture;
  Future swimJsonFuture;
  Future jumpJsonFuture;

  Fitness(userDataModel) {
    FitnessModel fitnessModel = FitnessModel();
    this.userDataModel = userDataModel;
    this.runJsonFuture  = fitnessModel.getActivityJson(RUN);
    this.swimJsonFuture = fitnessModel.getActivityJson(SWIM);
    this.jumpJsonFuture = fitnessModel.getActivityJson(JUMP);
  }
  
  @override
  _FitnessState createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<FitnessModel>(create: (context) => FitnessModel()),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text('Your Fitness'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_run)),
                  Tab(icon: Icon(FontAwesome5.swimmer)),
                  Tab(icon: Icon(Maki.basketball)),
                ],
              ),
            ),
            body: Consumer<FitnessModel>(
              builder: (context, fitnessModel, child) => TabBarView(
                children: [
                  FutureBuilder<Object>(
                    future: widget.runJsonFuture,
                    builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return Run(runJson: snapshot.data);
                        }
                    },
                  ),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
