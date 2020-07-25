import 'package:fima/screens/addFarmItem.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FarmItemList extends StatefulWidget {
  @override
  _FarmItemListState createState() => _FarmItemListState();
}

class _FarmItemListState extends State<FarmItemList> {
  String popMenu = "";
  @override
  Widget build(BuildContext context) {
    //final farmItemsBox = Hive.box('farmItems');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.cancel)),
        centerTitle: true,
        title: Text("Farm Items List"),
      ),
      body: Container(
        child: WatchBoxBuilder(
            box: Hive.box('farmItems'),
            builder: (context, farmItemsBox) {
              return ListView.builder(
                  itemCount: farmItemsBox.length,
                  itemBuilder: (context, index) {
                    final farmItem = farmItemsBox.getAt(index);
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                      child: Card(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.blue, width: 4))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(farmItem['itemName']),
                                ),
                                PopupMenuButton(
                                  onSelected: (val) {
                                    if (val == "delete") {
                                      farmItemsBox.deleteAt(index);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem(
                                          value: "delete",
                                          child: Text("Delete"))
                                    ];
                                  },
                                )
                              ],
                            )),
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddFarmItem())),
          child: Icon(
            Icons.add,
          )),
    );
  }
}
