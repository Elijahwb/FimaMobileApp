import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class NewIncomeScreen extends StatefulWidget {
  @override
  _NewIncomeScreenState createState() => _NewIncomeScreenState();
}

class _NewIncomeScreenState extends State<NewIncomeScreen> {
  bool _showIncomeSourceItem = false;
  bool _showOtherIncomeSource = false;
  String _selectedIncomeSource = incomeSource[0];
  String _selectedFarmItem = "";
  DateTime _selectedDate = DateTime.now();
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _earningController = TextEditingController();
  TextEditingController _invoiceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _otherIncomeSourceController = TextEditingController();

  final _farmItemsBox = Hive.box('farmItems');
  List<String> _myFarmItems = ["Select Farm Item"];

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel)),
        title: Text("New Income"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Map<String, dynamic> newIncome = {
                "source": _showIncomeSourceItem
                    ? _selectedFarmItem
                    : _showOtherIncomeSource
                        ? _otherIncomeSourceController.text
                        : Text("not specified"),
                "amount": double.parse(_earningController.text),
                "date": _selectedDate,
                "invoice": _invoiceController.text,
                "description": _descriptionController.text,
              };
              Hive.box('incomes').add(newIncome);
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
                        "From which source did you get the income?",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      elevation: 4,
                      underline: Text(""),
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 10.0),
                        child: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.orange,
                        ),
                      ),
                      isExpanded: true,
                      value: _selectedIncomeSource,
                      items: incomeSource.map((data) {
                        return DropdownMenuItem(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(data),
                          ),
                          value: data,
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          if (val == "--None Selected--" || val == "Other") {
                            _selectedIncomeSource = val;
                            setState(() {
                              _showIncomeSourceItem = false;
                              _showOtherIncomeSource = false;
                            });
                            if (val == "Other") {
                              setState(() {
                                _showOtherIncomeSource = true;
                              });
                            }
                          } else {
                            _selectedIncomeSource = val;
                            setState(() {
                              _showOtherIncomeSource = false;
                              _showIncomeSourceItem = true;
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
            //:::::::::::::::::::::::::::Item from which the income was obtained
            _showIncomeSourceItem
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _selectedIncomeSource,
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
                                  top: 8.0, bottom: 8.0, left: 10.0),
                              child: Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.orange,
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

            //::::::::::::::::::::::::::::::::::::::::::Other Income Source
            _showOtherIncomeSource
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Specify the source",
                              textScaleFactor: 1.1,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20),
                          height: 40,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _otherIncomeSourceController,
                            style: TextStyle(fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
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
                        "How much do you earn",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _earningController,
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
                        "Date of income",
                        textScaleFactor: 1.1,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    height: 40,
                    child: TextField(
                      onTap: () {
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
                      },
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
                      controller: _invoiceController,
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
            //:::::::::::::::::::::::::::::::::::::Description
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
                      controller: _descriptionController,
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
}

class TextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "How much do you earn",
                textScaleFactor: 1.1,
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            height: 40,
            child: TextField(
              style: TextStyle(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> incomeSource = [
  "--None Selected--",
  "Farm Item Sale",
  "Farm Product Sale",
  "Other",
];
