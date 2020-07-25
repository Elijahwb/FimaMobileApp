import 'package:fima/models/models.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  final User user;

  FeedScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: feedList.length,
        itemBuilder: (context, index) {
          return Feed(feed: feedList[index], user: user);
        });
  }
}
