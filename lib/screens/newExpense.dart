import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class NewExpenseScreen extends StatefulWidget {
  @override
  _NewExpenseScreenState createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  _initHive() async {
    final appDocsDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocsDirectory.path);
  }

  String _selectedExpenseType = expenseTypes[0];
  DateTime _selectedDate = DateTime.now();
  String _selectedFarmItem = "";

  bool _showFarmItems = false;
  bool _showOtherExpenses = false;

  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _spendController = TextEditingController();
  TextEditingController _invoiceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _otherExpenseSourceController = TextEditingController();

  final _farmItemsBox = Hive.box('farmItems');
  List<String> _myFarmItems = ["Select Farm Item"];
  @override
  void initState() {
    _initHive();
    if (_farmItemsBox.length > 0) {
      for (int i = 0; i < _farmItemsBox.length; i++) {
        _myFarmItems.add(_farmItemsBox.getAt(i)['itemName']);
        print(_farmItemsBox.getAt(i)['itemName']);
      }
    }
    setState(() {
      _selectedFarmItem = _myFarmItems[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox("expenses"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red,
                  leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.cancel)),
                  title: Text("New Expense"),
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> newExpense = {
                          "source": _showFarmItems
                              ? _selectedFarmItem
                              : _showOtherExpenses
                                  ? _otherExpenseSourceController.text
                                  : "Not Specified",
                          "amount": double.parse(_spendController.text),
                          "date": _selectedDate,
                          "invoice": _invoiceController.text,
                          "description": _descriptionController.text,
                        };
                        Hive.box('expenses').add(newExpense);
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
                      //::::::::::::::::::::::::::::::::::::::::Source of your income
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Select the type of expense",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton(
                                elevation: 4,
                                underline: Text(""),
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.red,
                                  ),
                                ),
                                isExpanded: true,
                                value: _selectedExpenseType,
                                items: expenseTypes.map((data) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(data),
                                    ),
                                    value: data,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedExpenseType = val;
                                    if (val == "--None Selected--" ||
                                        val == "Other") {
                                      setState(() {
                                        _showFarmItems = false;
                                        _showOtherExpenses = false;
                                        if (val == "Other") {
                                          setState(() {
                                            _showOtherExpenses = true;
                                          });
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        _showOtherExpenses = false;
                                        _showFarmItems = true;
                                      });
                                    }
                                  });
                                },
                                hint: Text("Select income source"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //::::::Show Farm Items

                      _showFarmItems
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _selectedExpenseType,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black26),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownButton(
                                      elevation: 4,
                                      underline: Text(""),
                                      icon: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, left: 10.0),
                                        child: Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: _selectedFarmItem,
                                      items: _myFarmItems.map((data) {
                                        return DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(data),
                                          ),
                                          value: data,
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _selectedFarmItem = val;
                                        });
                                      },
                                      hint: Text("Select Farm Item source"),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(""),
                      //:::::::::::::::::::::::::::::::::::Other expense item
                      _showOtherExpenses
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Specify Other Expense",
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20),
                                    height: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _otherExpenseSourceController,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(""),
                      //:::::::::::::::::::::::::::::::::::::::::::::::how much your earn
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "How much did you spend?",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 40,
                              child: TextField(
                                controller: _spendController,
                                keyboardType: TextInputType.number,
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
                      //:::::::::::::::::::::::::::::::::::::::::::::::::Date Picker
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Date of expense",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 40,
                              child: TextField(
                                controller: _datePickerController,
                                style: TextStyle(fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: _selectedDate,
                                                lastDate: _selectedDate,
                                                firstDate:
                                                    _selectedDate.subtract(
                                                        Duration(days: 1080)))
                                            .then((selectedDate) {
                                          setState(() {
                                            _selectedDate = selectedDate;
                                          });
                                          _datePickerController.text =
                                              DateFormat.yMEd()
                                                  .format(_selectedDate);
                                        });
                                      }),
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
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Invoice/Receipt No.(Optional)",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 40,
                              child: TextField(
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
                      //:::::::::::::::::::::::::::::::::::::::::::::::::::::::Description
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Description (Optional)",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              height: 60,
                              child: TextField(
                                style: TextStyle(fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  hintText: "Write short notes ...",
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

List<String> expenseTypes = [
  "--None Selected--",
  "Specific to a farm item",
  "Choose expense category",
  "Other",
];
