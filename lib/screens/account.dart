import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  final User user;

  AccountScreen(this.user);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  var _tabController;
  double _generalContainerHeight = 50;
  double _accountContainerHeight = 50;

  _toogleGeneralContainerHeight() {
    if (_generalContainerHeight == 50) {
      setState(() {
        _generalContainerHeight = 190;
      });
    } else {
      setState(() {
        _generalContainerHeight = 50;
      });
    }
  }

  _toogleAccountContainerHeight() {
    if (_accountContainerHeight == 50) {
      setState(() {
        _accountContainerHeight = 350;
      });
    } else {
      setState(() {
        _accountContainerHeight = 50;
      });
    }
  }

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
    var width = MediaQuery.of(context).size.width;
    //var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      body: ListView(
        children: <Widget>[
          AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2.0, color: Colors.black26))),
              height: _generalContainerHeight,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _toogleGeneralContainerHeight(),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2.0, color: Colors.black26))),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "General",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              FaIcon(FontAwesomeIcons.chevronDown, size: 20)
                            ],
                          ),
                        )),
                  ),
                  //:::::::::::::::::::::Content
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width,
                    height: 200,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ThemeBloc>(context)
                                ..add(DefaultTheme());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Text("Default theme",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ThemeBloc>(context)
                                ..add(DarkenTheme());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Text("Dark theme",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]),
                  )
                ],
              )),
          //::::::::::::::::::::::::::::::::::::::::account
          AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2.0, color: Colors.black26))),
              height: _accountContainerHeight,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _toogleAccountContainerHeight(),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2.0, color: Colors.black26))),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Personal Information",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              FaIcon(FontAwesomeIcons.chevronDown, size: 20)
                            ],
                          ),
                        )),
                  ),
                  //:::::::::::::::::::::Content
                  Container(
                    height: 280,
                    child: ListView(children: <Widget>[
                      //:::::::::::::::::::::::::::::::::::name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text("Name: ${tempUser.username}",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      //:::::::::::::::::::::::::::::::::::username
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text("Username: ${tempUser.username}",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      //:::::::::::::::::::::::::::::::::::password
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text("Password: ${tempUser.userPassword}",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      //:::::::::::::::::::::::::::::::::::email
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Email: ${tempUser.email == null ? 'No email provided' : tempUser.email}",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),

                      //:::::::::::::::::::::::::::::::::::phone number
                      tempUser.userType == "Farmer"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "Phone number: ${tempUser.phone == null ? 'No phone number provided' : tempUser.phone}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          : Text(""),
                      //::Farm Name captured
                      tempUser.userType == "Farmer"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "Farm Name: ${tempUser.farmName == null ? 'No phone number provided' : tempUser.farmName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          : Text(""),
                      //:: Street / Village captured
                      tempUser.userType == "Farmer"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "Street/Village: ${tempUser.streetVillage == null ? 'No phone number provided' : tempUser.streetVillage}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          : Text(""),
                      //:: Town / City captured
                      tempUser.userType == "Farmer"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "Town/City: ${tempUser.townCity == null ? 'No phone number provided' : tempUser.townCity}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          : Text(""),
                      //:: Country captured
                      tempUser.userType == "Farmer"
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "Country: ${tempUser.country == null ? 'No phone number provided' : tempUser.country}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )
                          : Text(""),
                    ]),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
