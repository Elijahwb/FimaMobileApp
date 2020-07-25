import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameKey = GlobalKey<FormFieldState<String>>();

  final _passwrodKey = GlobalKey<FormFieldState<String>>();
  final _emailKey = GlobalKey<FormFieldState<String>>();
  final _farmNameKey = GlobalKey<FormFieldState<String>>();
  final _villageKey = GlobalKey<FormFieldState<String>>();
  final _cityKey = GlobalKey<FormFieldState<String>>();
  final _phoneKey = GlobalKey<FormFieldState<String>>();
  final _countryKey = GlobalKey<FormFieldState<String>>();

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropDownMenuItems;
  Company _selectedCompany;
  String _status = "Extension Worker";

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _dropDownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(DropdownMenuItem(
        value: company,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            company.name,
            style: TextStyle(
                color: Color.fromRGBO(22, 66, 1, 1),
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
        ),
      ));
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      _status = selectedCompany.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          //::::::::::::::::::::::::::::::::::::::::::::::::::::DROP DOWN BUTTON
          Container(
            //width: MediaQuery.of(context).size.width * 0.40,
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                isExpanded: true,
                value: _selectedCompany,
                items: _dropDownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
            ),
          ),
          //::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::USERNAME
          CustomizedInput(
              inputKey: _usernameKey, title: "Username", status: "text"),
          //:::::::::::::::::::::::::::::::::::::::::::::USER PASSWORD
          CustomizedInput(
              inputKey: _passwrodKey, title: "Password", status: "text"),
          //:::::::::::::::::::::::::::::::::::::::::::::USER EMAIL
          CustomizedInput(inputKey: _emailKey, title: "Email", status: "email"),
          //:::::::::::::::::::::::::::::::::::::::::FARM INFORMATION
          _status == "Farmer"
              ? Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Farm Details",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                        child: Column(
                      children: <Widget>[
                        //::::::::::::::::::::::::::::::::::::::::::::FARM NAME
                        CustomizedInput(
                            inputKey: _farmNameKey,
                            title: "Farm Name",
                            status: "text"),
                        //::::::::::::::::::::::::::::::::::::::FARM STREET OR VILLAGE
                        CustomizedInput(
                            inputKey: _villageKey,
                            title: "Street/Village",
                            status: "text"),
                        //::::::::::::::::::::::::::::::::::::::FARM TOWN OR CITY
                        CustomizedInput(
                            inputKey: _cityKey,
                            title: "Town/City",
                            status: "text"),
                        //:::::::::::::::::::::::::::::::::::::::::::FARM PHONE NUMBER
                        CustomizedInput(
                            inputKey: _phoneKey,
                            title: "Phone",
                            status: "number"),
                        //:::::::::::::::::::::::::::::::::::::::::::FARM PHONE NUMBER
                        CustomizedInput(
                            inputKey: _countryKey,
                            title: "Country",
                            status: "text"),
                      ],
                    ))
                  ],
                )
              : SizedBox(height: 5),
          //:::::::::::::::::::::::::::::::::::::::::::::::::::::::SUBMIT BUTTON
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print(_emailKey.currentState.value);
                    User user = new User(
                        username: _usernameKey.currentState.value,
                        userPassword: _passwrodKey.currentState.value,
                        userType: _selectedCompany.name);
                    print(user.userType);
                    if (_status == "Extension Worker") {
                      user = new User(
                          username: _usernameKey.currentState.value,
                          userPassword: _passwrodKey.currentState.value,
                          email: _emailKey.currentState.value,
                          userType: _selectedCompany.name);
                    } else if (_status == "Farmer") {
                      user = new User(
                          userID: 1,
                          userPassword: _passwrodKey.currentState.value,
                          username: _usernameKey.currentState.value,
                          country: _countryKey.currentState.value,
                          townCity: _cityKey.currentState.value,
                          streetVillage: _villageKey.currentState.value,
                          phone: _phoneKey.currentState.value,
                          farmName: _farmNameKey.currentState.value,
                          userType: _selectedCompany.name);
                    }

                    BlocProvider.of<UseractivityBloc>(context)
                      ..add(Register(user));

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginScreen()));
                  }
                },
                child: Text("Sign up", style: TextStyle(color: Colors.white))),
          ),
          //::::::::::::::::::::::::::::::::::::::::FORGOT PASSWORD LINK
          Padding(
            padding: EdgeInsets.only(
                top: 10.0, right: MediaQuery.of(context).size.width * 0.06),
            child: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Have an account? Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                )),
          ),
        ]));
  }
}

class CustomizedInput extends StatelessWidget {
  var inputKey;
  String title;
  String status;

  CustomizedInput({this.inputKey, this.status, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title:",
            textScaleFactor: 1.2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          TextFormField(
            key: inputKey,
            validator: (value) {
              if (value.isEmpty) {
                return "Please provide ${title.toLowerCase()}";
              }
              return null;
            },
            keyboardType: status == "text"
                ? TextInputType.text
                : status == "number"
                    ? TextInputType.number
                    : status == "email" ? TextInputType.emailAddress : null,
            textCapitalization: TextCapitalization.sentences,
            cursorColor: Theme.of(context).primaryColor,
            cursorWidth: 3,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.green, width: 8, style: BorderStyle.solid),
                ),
                hintStyle: TextStyle(
                    color: Colors.black26, fontWeight: FontWeight.w600),
                focusColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
