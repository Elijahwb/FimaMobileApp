import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/screens/account.dart';
import 'package:fima/screens/donate_screen.dart';
import 'package:fima/screens/rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  final User user;

  MyDrawer(this.user);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.center,
        width: width / 1.5,
        height: height - (height * 0.2),
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 10.0)
            ]),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 45,
              child: Text(user.username),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20, left: 50),
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RulesScreen()));
                      },
                      child: ListTile(title: Text("Rules & Regulations"))),
                  ListTile(
                      title: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.phoneSquareAlt,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text("Contact Us"),
                    ],
                  )),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DonateScreen())),
                    child: ListTile(
                        title: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.gifts,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text("Donate"),
                      ],
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AccountScreen(user)));
                    },
                    child: ListTile(
                        title: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.usersCog,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text("Settings"),
                      ],
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<UseractivityBloc>(context)..add(LogOut());
                    },
                    child: ListTile(
                        title: Row(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.signOutAlt,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text("LogOut"),
                      ],
                    )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
