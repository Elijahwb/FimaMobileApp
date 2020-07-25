import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:fima/screens/landing.dart';
import 'package:fima/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  runApp(MyApp());
  final appDocsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocsDirectory.path);
  await Hive.openBox('users');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _newVisitor;

  Future<bool> _isUserNew() async {
    final SharedPreferences prefs = await _prefs;
    final bool newUser = (prefs.getBool("old") ?? false);
    return newUser;
  }

  getUserDetails() async {
    final SharedPreferences prefs = await _prefs;
    final int userId = prefs.getInt("userId");
    final String username = prefs.getString("username");
    final String userpassword = prefs.getString("userpassword");

    tempUser.userID = userId;
    tempUser.username = username;
    tempUser.userPassword = userpassword;
    return;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _newVisitor = _isUserNew();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return BlocProvider(
      create: (context) => UseractivityBloc(CredentialRepository()),
      child: BlocProvider(
        create: (context) => ThemeBloc(ThemeRepository()),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          if (state is ThemeInitial) {
            return MaterialApp(
                theme: ThemeData(
                    primaryColor: Color.fromRGBO(22, 66, 1, 1),
                    primarySwatch: Colors.green,
                    brightness: Brightness.light),
                debugShowCheckedModeBanner: false,
                home:
                    LoginScreen() /*FutureBuilder(
                    future: this._newVisitor,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        case ConnectionState.done:
                          if (snapshot.data) {
                            userValid = true;
                            getUserDetails();
                            return LandingScreen(tempUser);
                          } else {
                            return LoginScreen();
                          }
                          break;
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text("");
                          }
                      }
                    })*/
                );
          } else if (state is ThemeDarkened) {
            return MaterialApp(
                theme: ThemeData(
                  primaryColor: Color.fromRGBO(22, 66, 1, 1),
                  brightness: state.brightness,
                ),
                debugShowCheckedModeBanner: false,
                home: LoginScreen());
          } else {
            return Center(
              child: Text("am bad news"),
            );
          }
        }),
      ),
    );
  }
}
