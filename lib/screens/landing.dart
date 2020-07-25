import 'package:fima/models/models.dart';
import 'package:fima/screens/budget.dart';
import 'package:fima/screens/chat.dart';
import 'package:fima/screens/feeds.dart';
import 'package:fima/screens/training.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingScreen extends StatefulWidget {
  final User user;

  LandingScreen(this.user);
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  var _tabController;

  GlobalKey<ScaffoldState> _landingPageDrawer = GlobalKey();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _landingPageDrawer,
      drawer: MyDrawer(widget.user),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.bars,
            size: 20,
            color: Colors.white,
          ),
          iconSize: 29,
          onPressed: () {
            _landingPageDrawer.currentState.openDrawer();
          },
        ),
        title: Text(
          "FIMA",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => BudgetScreen())),
            child: Container(
                margin: EdgeInsets.only(right: 10.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.wallet,
                      size: 20.0,
                    ),
                    Text(
                      "Budget",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )
        ],
        bottom: TabBar(
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          isScrollable: true,
          indicatorColor: Colors.white70,
          indicatorWeight: 4,
          unselectedLabelStyle: TextStyle(color: Colors.black54),
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: null,
              text: "News".toUpperCase(),
            ),
            Tab(
              icon: null,
              text: "Training".toUpperCase(),
            ),
            Tab(
              icon: null,
              text: "Extensionist".toUpperCase(),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FeedScreen(widget.user),
        TrainingScreen(),
        ChatScreen(),
      ]),
    );
  }
}
