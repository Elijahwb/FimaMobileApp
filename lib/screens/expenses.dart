import 'package:fima/screens/editExpense.dart';
import 'package:fima/screens/newExpense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: WatchBoxBuilder(
            box: Hive.box('expenses'),
            builder: (context, expensesBox) {
              return ListView.builder(
                  itemCount: expensesBox.length,
                  itemBuilder: (context, index) {
                    final expense = expensesBox.getAt(index);
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                      child: Card(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.red, width: 4))),
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
                                            expense['source'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              DateFormat.yMMMEd()
                                                  .format(expense['date']),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600))
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
                                          "UGX${expense['amount'].toString()}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    PopupMenuButton(
                                      onSelected: (val) {
                                        if (val == "delete") {
                                          expensesBox.deleteAt(index);
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      EditExpenseScreen(
                                                          expenseKey: index)));
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return <PopupMenuEntry<String>>[
                                          PopupMenuItem(
                                              value: "edit",
                                              child: Text("Edit expense")),
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
            }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NewExpenseScreen())),
          child: Icon(
            Icons.add,
          )),
    );
  }
}
