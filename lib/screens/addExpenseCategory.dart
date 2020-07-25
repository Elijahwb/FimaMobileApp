import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddExpenseCategory extends StatefulWidget {
  @override
  _AddExpenseCategoryState createState() => _AddExpenseCategoryState();
}

class _AddExpenseCategoryState extends State<AddExpenseCategory> {
  TextEditingController _expenseCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel)),
        title: Text("Expense Category"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Map<String, dynamic> newFarmItem = {
                "categoryName": _expenseCategoryController.text,
              };
              Hive.box('expenseCategories').add(newFarmItem);
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
          child: ListView(padding: EdgeInsets.only(top: 20), children: <Widget>[
            //:::::::::::::::::::::::::::::::::::::::::::::::how much your earn
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name of expense category",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    height: 40,
                    child: TextField(
                      controller: _expenseCategoryController,
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
          ]),
        ),
      ),
    );
  }
}
