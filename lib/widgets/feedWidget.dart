import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:fima/screens/feedDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Feed extends StatelessWidget {
  final User user;
  final FeedClass feed;

  Feed({this.user, this.feed});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Colors.black.withOpacity(0.1)))),
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 6.0, bottom: 6.0),
        margin: EdgeInsets.only(bottom: 30.0, top: 5.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: feed.title,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FeedDetails(feed, user))),
                child: Container(
                  height: height / 5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      /*image: DecorationImage(
                        image: NetworkImage(feed.imageUrl), fit: BoxFit.cover),*/

                      ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.png',
                      image: feed.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5.0),
                Text(
                  feed.title,
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FeedDetails(feed, user))),
                  child: Text(
                    feed.feedInfo,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 20.0),
                BlocProvider(
                  create: (context) => FeedBloc(LikePostRepository()),
                  child: BlocBuilder<FeedBloc, FeedState>(
                    builder: (context, state) {
                      if (state is FeedInitial) {
                        return _commentSectionBuilder(context, user, feed);
                      } else if (state is PostLiked) {
                        return _commentSectionBuilder(context, user, feed);
                      }
                      return _commentSectionBuilder(context, user, feed);
                    },
                  ),
                ),
                SizedBox(height: 25)
              ],
            )),
          ],
        ));
  }
}

Widget _commentSectionBuilder(BuildContext context, User user, FeedClass feed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      GestureDetector(
          onTap: () {
            BlocProvider.of<FeedBloc>(context)
              ..add(LikePost(userID: user.userID, postID: feed.feedID));
          },
          child: Row(children: <Widget>[
            FaIcon(
              FontAwesomeIcons.thumbsUp,
              size: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Color.fromRGBO(22, 66, 1, 1),
            ),
            SizedBox(width: 2),
            Text(
              feed.numberOfLikes.length.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Color.fromRGBO(22, 66, 1, 1)),
            ),
          ])),
      GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => FeedDetails(feed, user))),
        child: Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.comment,
              size: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Color.fromRGBO(22, 66, 1, 1),
            ),
            SizedBox(width: 2),
            Text(feed.comments.length.toString())
          ],
        ),
      ),
      Row(children: <Widget>[
        Transform.rotate(
          angle: -0.3,
          child: FaIcon(
            FontAwesomeIcons.share,
            size: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Color.fromRGBO(22, 66, 1, 1),
          ),
        )
      ])
    ],
  );
}
