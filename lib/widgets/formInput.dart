import 'package:flutter/material.dart';

class MyFormInput extends StatefulWidget {
  final Widget icon;
  final String hintName;

  MyFormInput({this.hintName, this.icon});

  @override
  _MyFormInputState createState() => _MyFormInputState();
}

class _MyFormInputState extends State<MyFormInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black, width: 2.0))),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30.0, right: 5.0),
              child: widget.icon,
            ),
            Container(
                margin: EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width * 0.55,
                child: widget.hintName == "email"
                    ? TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please provide " + widget.hintName;
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            hintText: widget.hintName,
                            focusColor: Colors.white),
                      )
                    : widget.hintName == "Phone Number"
                        ? TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide " + widget.hintName;
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration.collapsed(
                                hintText: widget.hintName,
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                focusColor: Colors.white),
                          )
                        : TextFormField(
                            keyboardAppearance: Brightness.dark,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide " + widget.hintName;
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration.collapsed(
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                hintText: widget.hintName,
                                focusColor: Colors.white),
                          )),
          ],
        ),
      ),
    );
  }
}
