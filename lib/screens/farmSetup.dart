import 'package:fima/screens/expenseCategories.dart';
import 'package:fima/screens/farmItemList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FarmSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    alignment: Alignment.center,
                    child: FaIcon(FontAwesomeIcons.chevronCircleLeft,
                        size: 20.0))),
          ),
          title: Text("Farm Setup"),
        ),
        body: Container(
          child: GridView.count(
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: 10, top: 20, right: 10),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
            children: <Widget>[
              //::::::::::::::::::::::::::::::::::::::New Income
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FarmItemList())),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.tools,
                          size: 45,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Farm Items",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ]),
                ),
              ),
              //::::::::::::::::::::::::::::::::::::::New Income
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ExpenseCategories())),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? null
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.handHoldingUsd,
                          size: 45,
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Expense Categories",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}
