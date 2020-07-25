import 'package:fima/screens/summary.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

double initialExpenses() {
  double totalExpenses = 0;
  final expensesBox = Hive.box('expenses');
  for (int i = 0; i < expensesBox.length; i++) {
    var expenseAmount = expensesBox.getAt(i);
    totalExpenses = totalExpenses + expenseAmount['amount'];
  }
  return totalExpenses;
}

double initialIncome() {
  final incomesBox = Hive.box('incomes');
  double totalIncome = 0;
  for (int i = 0; i < incomesBox.length; i++) {
    var incomeAmount = incomesBox.getAt(i);
    totalIncome = totalIncome + incomeAmount['amount'];
  }
  return totalIncome;
}

class RangeNotifier with ChangeNotifier {
  DateTime _firstDate = DateTime.now();
  DateTime _lastDate = DateTime.now();

  final _expensesBox = Hive.box('expenses');
  final _incomesBox = Hive.box('incomes');

  double _totalIncome = initialIncome();
  double _totalExpenses = initialExpenses();

  updateDateRange(DateTime firstDate, DateTime lastDate) {
    _firstDate = firstDate;
    _lastDate = lastDate;

    notifyListeners();
  }

  updateAnalyticalData(String range) {
    print("inside updateAnalytical Data function");
    double newIncomeTotal = 0;
    double newExpenseTotal = 0;
    if (range == "Current Month") {
      print("now inside current month functionality");
      //fetch the incomes of this specific month
      for (int i = 0; i < _incomesBox.length; i++) {
        if (_incomesBox.getAt(i)["date"].month == DateTime.now().month) {
          newIncomeTotal = newIncomeTotal + _incomesBox.getAt(i)['amount'];
        }
      }
      //fetch the expenses of this specific month
      if (range == "Current Month") {
        for (int i = 0; i < _expensesBox.length; i++) {
          if (_expensesBox.getAt(i)["date"].month == DateTime.now().month) {
            newExpenseTotal = newExpenseTotal + _expensesBox.getAt(i)['amount'];
          }
        }
      }

      notifyListeners();
    } else if (range == "6 Months") {
      print("now inside 6 month functionality");
      //fetch the incomes of this specific month
      for (int i = 0; i < _incomesBox.length; i++) {
        print(_incomesBox.getAt(i)["date"]);
        if (_incomesBox.getAt(i)["date"] ==
            DateTime(DateTime.now().month - 6)) {
          newIncomeTotal = newIncomeTotal + _incomesBox.getAt(i)['amount'];
        }
      }
      //fetch the expenses of this specific month
      if (range == "6 Months") {
        for (int i = 0; i < _expensesBox.length; i++) {
          if (_incomesBox.getAt(i)["date"].month ==
              DateTime(DateTime.now().month - 6)) {
            newExpenseTotal = newExpenseTotal + _expensesBox.getAt(i)['amount'];
          }
        }
      }
      _lastDate = DateTime(DateTime.now().month - 6);
      _firstDate = DateTime.now();
      notifyListeners();
    }
  }

  DateTime get firstDate => _firstDate;
  DateTime get lastDate => _lastDate;
  double get totalIncome => _totalIncome;
  double get totalExpenses => _totalExpenses;
}

RelativeRect buttonMenuPosition(BuildContext c) {
  final RenderBox bar = c.findRenderObject();
  final RenderBox overlay = Overlay.of(c).context.findRenderObject();
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      bar.localToGlobal(bar.size.topRight(Offset(10, 40)), ancestor: overlay),
      bar.localToGlobal(bar.size.topRight(Offset(10, 40)), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
  return position;
}

List<String> incomeSource = [
  "Select farm item",
  "farm item 1",
];

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _analysisFilter = "Current Month";
  double _totalIncome = 0;
  double _totalExpenses = 0;
  final expensesBox = Hive.box('expenses');
  final incomesBox = Hive.box('incomes');

  String _selectedIncomeSource;

  updatePieData() {
    setState(() {
      for (int i = 0; i < expensesBox.length; i++) {
        var expenseAmount = expensesBox.getAt(i);
        _totalExpenses = _totalExpenses + expenseAmount['amount'];
      }
      for (int i = 0; i < incomesBox.length; i++) {
        var incomeAmount = incomesBox.getAt(i);
        _totalIncome = _totalIncome + incomeAmount['amount'];
      }
    });
  }

  customeRange(String val) {
    if (val == "Current Month") {
      print("inside current month");
      setState(() {
        _totalIncome = 0;
        _totalExpenses = 0;
      });
      updatePieData();
    } else if (val == "6 Months") {
      updatePieData();
      setState(() {
        _totalExpenses = _totalExpenses * 6 * 30;
        _totalIncome = _totalIncome * 6 * 30;
      });
    } else if (val == "1 Year") {
      updatePieData();
      setState(() {
        _totalIncome = _totalIncome * 12 * 30;
        _totalExpenses = _totalExpenses * 12 * 30;
      });
    }
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 2));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50));

    if (picked != null && picked.length == 2) {
      setState(() {
        _totalIncome = 0;
        _totalExpenses = 0;
      });

      updatePieData();

      final difference = picked[1].difference(picked[0]).inDays;

      setState(() {
        _totalIncome = _totalIncome * difference;
        _totalExpenses = _totalExpenses * difference;
        _analysisFilter =
            "${DateFormat.yMEd().format(picked[0])} - ${DateFormat.yMEd().format(picked[1])}";
      });
    }
  }

  final farmItemsBox = Hive.box('farmItems');
  List<String> myFarmItems = ["Select Farm Item"];
  @override
  void initState() {
    print("FarmItems Box lenght: ${farmItemsBox.length.toString()}");
    if (farmItemsBox.length > 0) {
      for (int i = 0; i < farmItemsBox.length; i++) {
        myFarmItems.add(farmItemsBox.getAt(i)['itemName']);
        print(farmItemsBox.getAt(i)['itemName']);
      }
      print(myFarmItems);
    }
    setState(() {
      _selectedIncomeSource = myFarmItems[0];
    });
    updatePieData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("New Farm Items Box lenght: ${myFarmItems.length.toString()}");
    return ChangeNotifierProvider(
      create: (_) => RangeNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton(
              elevation: 4,
              underline: Text(""),
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.white,
                ),
              ),
              isExpanded: true,
              value: _selectedIncomeSource,
              items: myFarmItems.map((data) {
                return DropdownMenuItem(
                  child: Text(
                    data,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  value: data,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedIncomeSource = val;
                  if (val == "Select Farm Item") {
                    setState(() {
                      _totalIncome = 0;
                      _totalExpenses = 0;
                    });
                    updatePieData();
                  } else {
                    setState(() {
                      _totalExpenses = 0;
                      _totalIncome = 0;
                      for (int i = 0; i < expensesBox.length; i++) {
                        var expenseAmount = expensesBox.getAt(i);
                        if (expenseAmount['source'] == val) {
                          _totalExpenses =
                              _totalExpenses + expenseAmount['amount'];
                        }
                      }
                      for (int i = 0; i < incomesBox.length; i++) {
                        var incomeAmount = incomesBox.getAt(i);
                        if (incomeAmount['source'] == val) {
                          _totalIncome = _totalIncome + incomeAmount['amount'];
                        }
                      }
                    });
                  }
                });
              },
              hint: Text("Select Farm source"),
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Consumer<RangeNotifier>(
              builder: (context, notifier, _) {
                return GestureDetector(
                  onTap: () async {
                    final position = buttonMenuPosition(context);
                    String result = await showMenu<String>(
                        context: context,
                        position: position,
                        items: [
                          PopupMenuItem(
                            value: "Current Month",
                            child: Text('Current Month'),
                          ),
                          PopupMenuItem(
                            value: "6 Months",
                            child: Text('6 Months'),
                          ),
                          PopupMenuItem(
                            value: "1 Year",
                            child: Text('1 Year'),
                          ),
                          PopupMenuItem(
                            value: "Custom",
                            child: Text('Custom'),
                          ),
                        ],
                        initialValue: _analysisFilter);

                    if (result != null) {
                      setState(() {
                        _analysisFilter = result;
                      });

                      if (result == "Custom") {
                        await displayDateRangePicker(context);
                      } else {
                        customeRange(result);
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.filter,
                      size: 20,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Consumer<RangeNotifier>(
                    builder: (context, notifier, _) {
                      return Container(
                        margin: EdgeInsets.only(left: 10.0),
                        alignment: Alignment.center,
                        child: Consumer<RangeNotifier>(
                          builder: (context, notifier, _) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: new Text(
                                '$_analysisFilter',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 130,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 30, left: 15.0, right: 15.0),
                      child: RaisedButton(
                        elevation: 2,
                        color: Colors.green,
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SummaryScreen())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.clipboardList,
                                color: Colors.white),
                            SizedBox(width: 5.0),
                            Text("Summary",
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //:::::::::::::::::::::::::::::::::::::::Pie Chart
              Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(),
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: MyChart(
                        totalExpenses: _totalExpenses,
                        totalIncome: _totalIncome,
                      ))),
              //:::::::::::::::::::::::::::::::::::;:::Pie Chart Labels
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 5,
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          "Income",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            "Expenses",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //:::::::::::::::::::::::::::::::::::::::::Simple summary
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Income:",
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "UGX ${_totalIncome.round().toString()}",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total Expense:",
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "UGX ${_totalExpenses.round().toString()}",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  //:::::::::::::::::::::::::::::::::::Net worth
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Net:",
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "UGX ${(_totalIncome - _totalExpenses).round().toString()}",
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyChart extends StatefulWidget {
  final double totalExpenses;
  final double totalIncome;

  MyChart({@required this.totalExpenses, @required this.totalIncome});

  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  @override
  Widget build(BuildContext context) {
    //final expense = expensesBox.getAt(index);
    //final expense = expensesBox.getAt(index);
    PieChartSectionData item1 = PieChartSectionData(
        color: Colors.red,
        value:
            widget.totalExpenses / (widget.totalExpenses + widget.totalIncome),
        title: "Expense",
        radius: widget.totalExpenses > widget.totalIncome ? 50 : 45,
        titleStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w500));
    PieChartSectionData item2 = PieChartSectionData(
        color: Colors.orange,
        value: widget.totalIncome / (widget.totalExpenses + widget.totalIncome),
        title: "Income",
        radius: widget.totalIncome > widget.totalExpenses ? 50 : 45,
        titleStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w500));
    _sections = [item1, item2];
    return Container(
        child: AspectRatio(
      aspectRatio: 1,
      child: PieChart(PieChartData(
          sections: _sections,
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
          sectionsSpace: 0)),
    ));
  }
}
