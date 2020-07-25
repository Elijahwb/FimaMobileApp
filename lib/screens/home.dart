//import 'package:app_official/models/models.dart';
import 'package:fima/screens/analytics.dart';
import 'package:fima/screens/farmSetup.dart';
import 'package:fima/screens/newExpense.dart';
import 'package:fima/screens/newIncome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:hive/hive.dart';
//import 'dart:convert';

class HomeBudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 18,
                  children: <Widget>[
                    //::::::::::::::::::::::::::::::::::::::New Income
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => NewIncomeScreen())),
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
                                color: Colors.orange,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "New Income",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                    ),
                    //::::::::::::::::::::::::::::::::::::::New Expense
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NewExpenseScreen())),
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
                                FontAwesomeIcons.moneyBillAlt,
                                size: 45,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "New Expense",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                    ),
                    //::::::::::::::::::::::::::::::::::::::Farm Setup
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => FarmSetupScreen())),
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
                                FontAwesomeIcons.toolbox,
                                size: 45,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Farm Setup",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                    ),
                    //::::::::::::::::::::::::::::::::::::::analytics
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AnalyticsScreen())),
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
                                FontAwesomeIcons.chartPie,
                                size: 45,
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Analytics",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ]),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
