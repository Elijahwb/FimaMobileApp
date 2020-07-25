import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddFarmItem extends StatefulWidget {
  @override
  _AddFarmItemState createState() => _AddFarmItemState();
}

class _AddFarmItemState extends State<AddFarmItem> {
  TextEditingController _farmItemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel)),
        title: Text("New Farm Item"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Map<String, dynamic> newFarmItem = {
                "itemName": _farmItemController.text,
                "product1": "",
                "product2": "",
                "product3": "",
                "product4": "",
                "product5": "",
              };
              Hive.box('farmItems').add(newFarmItem);
              Navigator.of(context).pop();
            },
            child: Container(
                margin: EdgeInsets.only(right: 10.0),
                alignment: Alignment.center,
                child: Text("SAVE")),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: ListView(children: <Widget>[
            //:::::::::::::::::::::::::::::::::::::::::::::::how much your earn
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter the name of farm item *",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    height: 40,
                    child: TextField(
                      controller: _farmItemController,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //:::::::::::::::::::::::::::::::::::::::::::::::::Invoice number
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Please specify any products or services you sell from this farm item. (Optional)",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        height: 40,
                        child: TextField(
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: "First product or service (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: "Other product or service (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: "Other product or service (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: "Other product or service (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        height: 40,
                        child: TextField(
                          style: TextStyle(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: "Other product or service (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
