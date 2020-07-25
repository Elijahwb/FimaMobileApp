import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedDetails extends StatefulWidget {
  final FeedClass feed;
  final User user;

  FeedDetails(this.feed, this.user);

  @override
  _FeedDetailsState createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> {
  bool islikable = true;
  bool inputVisible = false;
  String userComment = "";
  double opacity = 0.0;
  final FocusNode currentNode = FocusNode();

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputVisible = false;
  }

  void toggleVisibility() {
    if (inputVisible == false) {
      setState(() {
        inputVisible = true;
        opacity = 1;
      });
    } else {
      setState(() {
        inputVisible = false;
        opacity = 0.0;
      });
    }
  }

  void fillUserComment(String input) {
    setState(() {
      userComment = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(widget.feed.title)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
            width: width,
            child: Stack(children: <Widget>[
              ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: widget.feed.title,
                        child: Container(
                            height: height / 3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(widget.feed.imageUrl),
                                    fit: BoxFit.cover))),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              widget.feed.feedInfo,
                              textScaleFactor: 1.1,
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocProvider(
                            create: (context) => FeedBloc(LikePostRepository()),
                            child: BlocBuilder<FeedBloc, FeedState>(
                              builder: (context, state) {
                                if (state is FeedInitial) {
                                  return _commentSectionBuilder(
                                      context,
                                      widget.user,
                                      widget.feed,
                                      this.toggleVisibility);
                                } else if (state is PostLiked ||
                                    state is PostCommented) {
                                  return _commentSectionBuilderLiked(
                                      context,
                                      widget.user,
                                      widget.feed,
                                      this.toggleVisibility);
                                }
                                return _commentSectionBuilder(
                                    context,
                                    widget.user,
                                    widget.feed,
                                    this.toggleVisibility);
                              },
                            ),
                          ),
                        ),
                      ]),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Comments",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                  children:
                                      widget.feed.comments.reversed.map((data) {
                                return CommentWidget(data);
                              }).toList()),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
              //::::::::::::::::::::::::::::::::::::::::::::::::Input text field
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: opacity,
                  child: BlocProvider(
                    create: (context) => FeedBloc(LikePostRepository()),
                    child: BlocBuilder<FeedBloc, FeedState>(
                        builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black87
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: TextField(
                            focusNode: currentNode,
                            controller: _controller,
                            style: TextStyle(fontWeight: FontWeight.w500),
                            cursorColor: Theme.of(context).primaryColor,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidComment,
                                    ),
                                    onPressed: null),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      BlocProvider.of<FeedBloc>(context)
                                        ..add(CommentOnPost(
                                            username: widget.user.username,
                                            postID: widget.feed.feedID,
                                            comment: _controller.text));

                                      _controller.text = "";

                                      currentNode.unfocus();
                                      toggleVisibility();
                                    }),
                                hintText: " Comment...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ])),
      ),
    );
  }
}

Widget _commentSectionBuilder(
    BuildContext context, User user, FeedClass feed, dynamic func) {
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
            Text(feed.numberOfLikes.length.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Color.fromRGBO(22, 66, 1, 1),
                )),
          ])),
      GestureDetector(
        onTap: () {
          func();
        },
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
          child: IconButton(
            onPressed: () {
              _showDialog(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.share,
              size: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Color.fromRGBO(22, 66, 1, 1),
            ),
          ),
        )
      ]),
    ],
  );
}

Widget _commentSectionBuilderLiked(
    BuildContext context, User user, FeedClass feed, dynamic func) {
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
              FontAwesomeIcons.solidThumbsUp,
              size: 20,
              color: Color.fromRGBO(22, 66, 1, 1),
            ),
            SizedBox(width: 2),
            Text(
              feed.numberOfLikes.length.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(22, 66, 1, 1)),
            ),
          ])),
      GestureDetector(
        onTap: () {
          func();
        },
        child: Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.comment,
              size: 20,
              color: Color.fromRGBO(22, 66, 1, 1),
            ),
            SizedBox(width: 2),
            Text(feed.comments.length.toString())
          ],
        ),
      ),
      Row(children: <Widget>[
        Transform.rotate(
          angle: -0.3,
          child: IconButton(
            onPressed: () {
              _showDialog(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.share,
              size: 20,
              color: Color.fromRGBO(22, 66, 1, 1),
            ),
          ),
        )
      ]),
    ],
  );
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData(dialogBackgroundColor: Colors.greenAccent),
          child: AlertDialog(
            title: new Text("Share"),
            content: new Text("Share This Post"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text("Close"))
            ],
          ),
        );
      });
}
