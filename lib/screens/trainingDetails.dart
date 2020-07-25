import 'dart:io';

import 'package:fima/models/models.dart';
import 'package:fima/screens/screens.dart';
import 'package:fima/widgets/cheweiItem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:video_player/video_player.dart';

class TrainingDetailScreen extends StatefulWidget {
  final TrainingModel training;
  TrainingDetailScreen(this.training);
  @override
  _TrainingDetailScreenState createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  List<String> comments = List<String>();
  double opacity = 0.0;
  bool inputVisible = false;
  double _commentsHeight = 0;
  final pdf = pdfWidgets.Document();
  TextEditingController _controller = TextEditingController();
  final FocusNode currentNode = FocusNode();

  _toggleVisibility() {
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

  _updateComments(String comment) {
    setState(() {
      comments.add(comment);
    });
  }

  _toggleCommentsHeight() {
    setState(() {
      if (_commentsHeight == 0) {
        _commentsHeight = 200;
      } else {
        _commentsHeight = 0;
      }
    });
  }

  _writeOnPdf() {
    List paragrapghs = widget.training.description.split("\n\n");

    List<pdfWidgets.Widget> documentParagraphs = paragrapghs.map((paragraph) {
      return pdfWidgets.Paragraph(text: paragraph);
    }).toList();

    pdf.addPage(pdfWidgets.MultiPage(
        pageFormat: PdfPageFormat.standard,
        margin: pdfWidgets.EdgeInsets.all(32),
        build: (pdfWidgets.Context context) {
          return <pdfWidgets.Widget>[
            pdfWidgets.Header(
                level: 0,
                textStyle: pdfWidgets.TextStyle(
                    fontWeight: pdfWidgets.FontWeight.bold),
                child: pdfWidgets.Text(
                    "Fima Introduction to Manure and Fertilizers")),
            documentParagraphs[0],
            documentParagraphs[1]
          ];
        }));
  }

  Future _savePdf() async {
    if (Platform.isAndroid) {
      Directory documentDirectory = await getExternalStorageDirectory();
      String documentPath = documentDirectory.path;

      File file = File('$documentPath/Fima_${widget.training.title}.pdf');

      file.writeAsBytesSync(pdf.save());
    }
  }

  @override
  Widget build(BuildContext context) {
    List paragraphs = widget.training.description.split("\n\n");
    print(paragraphs.length.toString());
    print(paragraphs);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(widget.training.title)),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ChewieItem(
                  videoPlayerController:
                      VideoPlayerController.network(widget.training.videoUrl)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _toggleCommentsHeight(),
                          child: Row(
                            children: <Widget>[
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: FaIcon(FontAwesomeIcons.signal,
                                      size: 12.0)),
                              Text("Comments List",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _toggleVisibility(),
                          child: Row(
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.commentDots,
                                size: 20,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Color.fromRGBO(22, 66, 1, 1),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Comment",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              //::::::::::::::::::::::::::::::::::::::::::::Comments section
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                height: _commentsHeight,
                child: comments.length == 0
                    ? Center(
                        child: Text(
                          "No Comments",
                          textScaleFactor: 1.2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView(
                        children: comments.map((comment) {
                          return Container(
                            width: MediaQuery.of(context).size.width - 20,
                            margin: EdgeInsets.only(
                                left: 5, right: 10.0, bottom: 10.0, top: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        tempUser.username,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2),
                                      Text(comment),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.training.title,
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(widget.training.description),
                      )
                    ]),
              ),
              Container(
                  width: 100,
                  margin: EdgeInsets.only(
                      left: 10.0,
                      right: MediaQuery.of(context).size.width * 0.56),
                  child: FlatButton(
                    onPressed: () async {
                      _writeOnPdf();
                      await _savePdf();
                      String documentPath = "";
                      if (Platform.isAndroid) {
                        Directory documentDirectory =
                            await getExternalStorageDirectory();
                        documentPath = documentDirectory.path;
                      }

                      String pdfPath =
                          '$documentPath/Fima_${widget.training.title}.pdf';
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Theme(
                              data: ThemeData(
                                  dialogBackgroundColor: Colors.white),
                              child: AlertDialog(
                                title: Text(
                                  "PDF Created",
                                  textAlign: TextAlign.center,
                                ),
                                content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.green))),
                                        child: GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) =>
                                                      PdfViewScreen(pdfPath))),
                                          child: Text(
                                            "View PDF",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("Close",
                                              style: TextStyle(
                                                  color: Colors.green)))
                                    ]),
                                actions: <Widget>[],
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.file_download, color: Colors.green),
                        Text(
                          "PDF",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          //::::::::::::::::::::::::::::::::::::::::::::::::Input text field
          inputVisible
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: opacity,
                      child: Container(
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
                                      _updateComments(_controller.text);
                                      _controller.text = "";

                                      currentNode.unfocus();
                                      _toggleVisibility();
                                    }),
                                hintText: " Comment...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      )))
              : Text(""),
        ],
      ),
    );
  }
}
