import 'package:fima/functions/functions..dart';
import 'package:fima/models/models.dart';
import 'package:fima/screens/trainingDetails.dart';
import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            "Get Trained For The Categories Below",
            textScaleFactor: 1.1,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              childAspectRatio: 1.0,
              padding: EdgeInsets.only(left: 10, top: 20, right: 10),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 18,
              children: trainingModels.map((data) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(createRoute(TrainingDetailScreen(data)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 4.0,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.png',
                            image: data.imageUrl,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            data.title.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black54
                                    : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              data.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      )),
    );
  }
}
