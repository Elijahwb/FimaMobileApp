import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 0.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.chevron_left,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
