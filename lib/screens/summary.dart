import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalIncome = 0;
    double totalExpenses = 0;
    final expensesBox = Hive.box('expenses');
    final incomesBox = Hive.box('incomes');
    List<Map<String, dynamic>> incomesList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> expensesList = List<Map<String, dynamic>>();

    for (int i = 0; i < expensesBox.length; i++) {
      var expenseAmount = expensesBox.getAt(i);
      expensesList.add(
          {"name": expenseAmount['source'], "amount": expenseAmount['amount']});
      totalExpenses = totalExpenses + expenseAmount['amount'];
    }
    for (int i = 0; i < incomesBox.length; i++) {
      var incomeAmount = incomesBox.getAt(i);
      incomesList.add(
          {"name": incomeAmount['source'], "amount": incomeAmount['amount']});
      totalIncome = totalIncome + incomeAmount['amount'];
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Summary",
          )),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                //::::::::::::::::::::::::::::::::::::Incomes List
                Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26, width: 1.2))),
                      child: Text(
                        "Income",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          //::::::::::::::::::::::::::::::List of Income items
                          Column(
                            children: incomesList.map((income) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        income['name'],
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'UGX ${income['amount'].toString()}',
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green),
                                      ),
                                    ]),
                              );
                            }).toList(),
                          ),
                          //:::::::::::::::::::::::::::::::::::::Income total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total:",
                                    textScaleFactor: 1.15,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "UGX ${totalIncome.toString()}",
                                    textScaleFactor: 1.15,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                //::::::::::::::::::::::::::::::::::::Expenses List
                Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black26, width: 1.2))),
                      child: Text(
                        "Expenses",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          //::::::::::::::::::::::::::::::List of Expenses items
                          Column(
                            children: expensesList.map((expense) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        expense['name'],
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "UGX ${expense['amount'].toString()}",
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green),
                                      ),
                                    ]),
                              );
                            }).toList(),
                          ),
                          //:::::::::::::::::::::::::::::::::::::Expense total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total:",
                                    textScaleFactor: 1.15,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "UGX ${totalExpenses.toString()}",
                                    textScaleFactor: 1.15,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          //::::::::::::::::::::::::Net Income

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Net:",
                      textScaleFactor: 1.3,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "UGX ${(totalIncome - totalExpenses).toString()}",
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                  ]),
            ),
          ),
        ],
      )),
    );
  }
}
