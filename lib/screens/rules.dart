import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules And Regulations'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              title: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '1.', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ' For any information shared must be verified first by the extension worker.',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              title: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '2.', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ' Making fraudulent offers of products, items is unacceptable.',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ])),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              title: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '3.', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ' Information not related to agricultural information management is not allowed.',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              title: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: "4.", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ' For any addition or deletion requests must be sent to the extension worker for approval.',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: ListTile(
              enabled: true,
              title: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: '5.', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ' Any form of harassment is prohibited.',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
            ),
          ),
        ],
      ),
    );
  }
}
