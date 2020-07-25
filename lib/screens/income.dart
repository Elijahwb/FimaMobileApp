//import 'dart:convert';

import 'package:fima/screens/editIncome.dart';
import 'package:fima/screens/newIncome.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

//import "package:intl/intl.dart";
class IncomeScreen extends StatelessWidget {
  final incomesBox = Hive.box('incomes');
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
          child: WatchBoxBuilder(
              box: Hive.box('incomes'),
              builder: (context, incomesBox) {
                return ListView.builder(
                    itemCount: incomesBox.length,
                    itemBuilder: (context, index) {
                      final income = incomesBox.getAt(index);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10.0),
                        child: Card(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.orange, width: 4))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              income['source'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                "${DateFormat.MMMEd().format(income['date'])}")
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Icon(Icons.star_border),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                            "UGX${income['amount'].toString()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      PopupMenuButton(
                                        onSelected: (val) {
                                          if (val == "delete") {
                                            incomesBox.deleteAt(index);
                                          } else if (val == "edit") {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditIncomeScreen(
                                                            incomeKey: index)));
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return <PopupMenuEntry<String>>[
                                            PopupMenuItem(
                                                value: "edit",
                                                child: Text("Edit income")),
                                            PopupMenuItem(
                                                value: "delete",
                                                child: Text("Delete")),
                                          ];
                                        },
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NewIncomeScreen())),
          child: Icon(
            Icons.add,
          )),
    );
  }
}

List<String> incomeSources = [
  "Job",
];
