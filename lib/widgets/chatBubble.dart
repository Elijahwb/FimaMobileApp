import 'package:fima/models/models.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  ChatBubble(this.message);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //var height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(
          right: message.admin ? 0 : width * 0.2,
          left: message.admin ? width * 0.2 : 0,
        ),
        child: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              child: message.admin
                  ? Container(
                      margin: EdgeInsets.only(left: 35, bottom: 2),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Consultant",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  : Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text("A"),
                          backgroundColor: Colors.greenAccent,
                        ),
                        SizedBox(width: 5),
                        Text(tempUser.username)
                      ],
                    )),
          Container(
              width: width * 0.6,
              decoration: BoxDecoration(
                  color: message.admin ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message.message,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              )),
          Container(
              margin: EdgeInsets.only(right: width * 0.10, top: 2.0),
              alignment: Alignment.centerRight,
              child: Text(
                "10:10 AM",
                style: TextStyle(fontWeight: FontWeight.w500),
              ))
        ]));
  }
}
