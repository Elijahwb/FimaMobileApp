import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class EditExpenseScreen extends StatefulWidget {
  final int expenseKey;
  EditExpenseScreen({this.expenseKey});
  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final expensesBox = Hive.box('expenses');

  DateTime _selectedDate = DateTime.now();
  String _selectedExpenseType = expenseTypes[0];
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _spendController = TextEditingController();
  TextEditingController _invoiceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  var expenseToEdit;
  @override
  void initState() {
    expenseToEdit = expensesBox.getAt(widget.expenseKey);
    _spendController.text = expenseToEdit['amount'].toString();
    _invoiceController.text = expenseToEdit['invoice'];
    _descriptionController.text = expenseToEdit['description'];
    _datePickerController.text =
        DateFormat.yMEd().format(expenseToEdit['date']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Edit Expense"),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  expensesBox.putAt(widget.expenseKey, {
                    "source": _selectedExpenseType,
                    "amount": double.parse(_spendController.text),
                    "date": _selectedDate,
                    "invoice": _invoiceController.text,
                    "description": _descriptionController.text,
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    alignment: Alignment.center,
                    child: Text("UPDATE")),
              )
            ]),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                        elevation: 4,
                        underline: Text(""),
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.red,
                          ),
                        ),
                        isExpanded: true,
                        value: _selectedExpenseType,
                        items: expenseTypes.map((data) {
                          return DropdownMenuItem(
                            child: Text(data),
                            value: data,
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedExpenseType = val;
                          });
                        },
                        hint: Text("Select income source"),
                      ),
                    ),
                  ],
                ),
              ),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                                        firstDate: _selectedDate
                                            .subtract(Duration(days: 1080)))
                                    .then((selectedDate) {
                                  setState(() {
                                    _selectedDate = selectedDate;
                                  });
                                  _datePickerController.text =
                                      DateFormat.yMEd().format(_selectedDate);
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
        ));
  }
}

List<String> expenseTypes = [
  "--None Selected--",
  "Specific to a farm item",
  "Choose expense category",
  "Other",
];
