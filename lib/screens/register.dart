import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/screens/login.dart';
import 'package:fima/screens/screens.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/apple.jpg"),
                        fit: BoxFit.contain)),
              ),
              SingleChildScrollView(
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  height: height + height * 0.8,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.1,
                            ),
                            width: MediaQuery.of(context).size.width * 0.85,
                            color: Colors.transparent,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: FormHeader(
                                    headerText: "SIGN UP",
                                    textColor: Colors.black,
                                  ),
                                ),
                                RegisterForm()
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: MyBackButton(),
              ),
            ]));
  }
}
