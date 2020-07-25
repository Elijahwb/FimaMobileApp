import 'package:fima/screens/expenses.dart';
import 'package:fima/screens/home.dart';
import 'package:fima/screens/income.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with TickerProviderStateMixin {
  var _tabController;
  Future _initHive() async {
    final appDocsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocsDirectory.path);
    await Hive.openBox('farmItems');
    await Hive.openBox('expenseCategories');
    await Hive.openBox('incomes');
    await Hive.openBox('expenses');
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initHive(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return BudgetScreen();
            } else {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.chevronCircleLeft,
                      size: 20,
                      color: Colors.white,
                    ),
                    iconSize: 29,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.wallet,
                        size: 20.0,
                      ),
                      Text("My Budget"),
                    ],
                  ),
                  bottom: TabBar(
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    isScrollable: true,
                    indicatorColor: Colors.white70,
                    indicatorWeight: 4,
                    unselectedLabelStyle: TextStyle(color: Colors.black54),
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: null,
                        text: "HOME",
                      ),
                      Tab(
                        icon: null,
                        text: "INCOME",
                      ),
                      Tab(
                        icon: null,
                        text: "EXPENSES",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(controller: _tabController, children: [
                  HomeBudgetScreen(),
                  IncomeScreen(),
                  ExpensesScreen(),
                ]),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    Hive.box('incomes').close();
    super.dispose();
  }
}
