import 'package:fima/screens/addExpenseCategory.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseCategories extends StatefulWidget {
  @override
  _ExpenseCategoriesState createState() => _ExpenseCategoriesState();
}

class _ExpenseCategoriesState extends State<ExpenseCategories> {
  @override
  Widget build(BuildContext context) {
    //final expenseCategoriesBox = Hive.box('expenseCategories');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel)),
        centerTitle: true,
        title: Text("Expense Categories"),
      ),
      body: Container(
        child: WatchBoxBuilder(
            box: Hive.box('expenseCategories'),
            builder: (context, expenseCategoryBox) {
              return ListView.builder(
                  itemCount: expenseCategoryBox.length,
                  itemBuilder: (context, index) {
                    final expenseCategory = expenseCategoryBox.getAt(index);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(expenseCategory['categoryName']),
                                ),
                                PopupMenuButton(
                                  onSelected: (val) {
                                    if (val == "delete") {
                                      expenseCategoryBox.deleteAt(index);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem(
                                          value: "delete",
                                          child: Text("Delete"))
                                    ];
                                  },
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
              .push(MaterialPageRoute(builder: (_) => AddExpenseCategory())),
          child: Icon(
            Icons.add,
          )),
    );
  }
}
