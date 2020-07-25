import 'package:fima/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  final _passwordKey1 = GlobalKey<FormFieldState<String>>();

  final _passwrodKey2 = GlobalKey<FormFieldState<String>>();

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
                  "New Password:",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  key: _passwordKey1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide password";
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
                  "Confirm Password:",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                TextFormField(
                  key: _passwrodKey2,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please confirm password";
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

          //::::::::::::::::::::::::::::::::::::::::LOGIN BUTTON
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    BlocProvider.of<UseractivityBloc>(context)
                      ..add(LogIn(
                          password: _passwrodKey2.currentState.value,
                          username: _passwordKey1.currentState.value));
                  }
                },
                child: Text("Submit", style: TextStyle(color: Colors.white))),
          ),
        ]));
  }
}
