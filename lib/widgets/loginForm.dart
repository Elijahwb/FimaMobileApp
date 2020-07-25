import 'package:fima/bloc/bloc.dart';
import 'package:fima/screens/forgotPassword.dart';
import 'package:fima/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameKey = GlobalKey<FormFieldState<String>>();

  final _passwrodKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Username:",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  key: _usernameKey,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide username";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 3,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 8,
                            style: BorderStyle.solid),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black26, fontWeight: FontWeight.w600),
                      focusColor: Colors.white),
                ),
              ],
            ),
          ),
          //:::::::::::::::::::::::::::::::::::::::::::::USER PASSWORD
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Password:",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  key: _passwrodKey,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide username";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 3,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 8,
                            style: BorderStyle.solid),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black26, fontWeight: FontWeight.w600),
                      focusColor: Colors.white),
                ),
              ],
            ),
          ),
          //::::::::::::::::::::::::::::::::::::::::FORGOT PASSWORD LINK
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, right: MediaQuery.of(context).size.width * 0.06),
            child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ForgotPasswordScreen())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                )),
          ),
          //::::::::::::::::::::::::::::::::::::::::LOGIN BUTTON
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    BlocProvider.of<UseractivityBloc>(context)
                      ..add(LogIn(
                          password: _passwrodKey.currentState.value,
                          username: _usernameKey.currentState.value));
                  }
                },
                child: Text("Login", style: TextStyle(color: Colors.white))),
          ),
          //::::::::::::::::::::::::::::::::::::::::::::REGISTER LINK
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen())),
                child: Text.rich(
                  TextSpan(children: <TextSpan>[
                    TextSpan(text: "Have no Account?"),
                    TextSpan(
                      text: " Register.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                )),
          ),
        ]));
  }
}
