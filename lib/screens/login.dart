import 'package:fima/bloc/bloc.dart';
import 'package:fima/screens/screens.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return BlocListener<UseractivityBloc, UseractivityState>(
      listener: (BuildContext context, state) {
        if (state is LogInFailed) {
          _showIt(context);
        }
      },
      child: BlocBuilder<UseractivityBloc, UseractivityState>(
        builder: (context, state) {
          if (state is UseractivityInitial || state is Registered) {
            //::::::::::::::::::::::::::::::::::::::::::::initial state
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/apple.jpg"),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white24,
                  child: Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Text(
                        "FIMA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                      )), //22, 66, 1, 0.19TODO:
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: MediaQuery.of(context).size.width * 0.075),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 25.0),
                        ),
                        LoginForm(),
                      ],
                    )),
              ]),
            );
          } else if (state is Loading) {
            //:::::::::::::::::::::::::::::::::::::::::::Loading State
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/apple.jpg"),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white24, //22, 66, 1, 0.19TODO:
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: MediaQuery.of(context).size.width * 0.075),
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                        LoginForm(),
                      ],
                    )),
                _buildLoadingScreen(context),
              ]),
            );
          } else if (state is LogInFailed) {
            //:::::::::::::::::::::::::::::::::::::::::::LogInFailed State

            return Scaffold(
              bottomNavigationBar: Container(
                  color: Colors.green,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Text("Your username or password is wrong",
                      style: TextStyle(color: Colors.red))),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/apple.jpg"),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white24, //22, 66, 1, 0.19TODO:
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: MediaQuery.of(context).size.width * 0.075),
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                        LoginForm(),
                      ],
                    )),
              ]),
            );
          } else if (state is LoggedIn) {
            //::::::::::::::::::::::::::::::::::::::::::::::::::::user valid
            return LandingScreen(state.user);
          }
          return Center(child: Text("What!!"));
        },
      ),
    );
  }
}

Widget _buildLoadingScreen(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    color: Colors.black54,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    ),
  );
}

_showIt(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    duration: Duration(seconds: 10),
    content: Text(
      "Username or password is incorrect",
      textScaleFactor: 1.1,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    ),
  ));
}
