import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.handsHelping,
                        color: Colors.black87,
                      ),
                      Text(
                        "Donate",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text("Want To Donate?",
                          textScaleFactor: 1.7,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("Choose any one",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54)),
                    ],
                  )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 50,
                            child: FaIcon(
                              FontAwesomeIcons.solidMoneyBillAlt,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Donate Money",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    "Send money with\nany line",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(50)),
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: FaIcon(FontAwesomeIcons.seedling,
                                      size: 40, color: Colors.black87))),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Donate Items",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87),
                                  ),
                                  Text(
                                    "Donate agricultural\n items",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                child: Icon(
                  Icons.chevron_left,
                  size: 30,
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 60,
        width: width,
        color: Theme.of(context).primaryColor,
        child: Text(
          "We thank you for your generosity",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
