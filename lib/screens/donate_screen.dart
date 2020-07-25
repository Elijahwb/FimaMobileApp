import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonateBubble extends StatefulWidget {
  final String donationString;
  final int donationReplies;
  final Function replyVisibility;
  final int id;

  DonateBubble(
      {this.donationString,
      this.replyVisibility,
      this.id,
      this.donationReplies});

  @override
  _DonateBubbleState createState() => _DonateBubbleState();
}

class _DonateBubbleState extends State<DonateBubble> {
  int _replies = 0;

  @override
  Widget build(BuildContext context) {
    Comment(userName: "wavah", comment: "some comment");
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.donationString),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.comments,
                            size: 20,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Color.fromRGBO(22, 66, 1, 1),
                          ),
                          SizedBox(width: 2),
                          Text(widget.donationReplies.toString())
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.replyVisibility(widget.id);
                    setState(() {
                      _replies++;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      RotatedBox(
                          quarterTurns: 2,
                          child: FaIcon(
                            FontAwesomeIcons.reply,
                            size: 20,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Color.fromRGBO(22, 66, 1, 1),
                          )),
                      Text(
                        "Reply",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Color.fromRGBO(22, 66, 1, 1),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ]),
    );
  }
}

class Donation {
  final int id;
  final String donationInfo;
  int donationMessages;

  Donation({this.donationMessages, this.donationInfo, this.id});
}

class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final List<Donation> donations = [
    Donation(
        id: 1,
        donationInfo:
            "Anyone with a poultry project, please contact me. I have space were you can operate and we can discuss about gains deeper. tel: 07445628976",
        donationMessages: 0),
    Donation(
        id: 2,
        donationInfo:
            "Am startign up a piggery project, and looking for people to join me who purely love and have some valuable knowledge in this feild",
        donationMessages: 0),
    Donation(
        id: 3,
        donationInfo:
            "I have land ready prepared but I don't have enough capital to start up a coffee plantation, anyone who can help with the capital of UGX 20M please call on +234 756 94549 45",
        donationMessages: 0),
  ];

  _addDonation(Donation donation) {
    setState(() {
      donations.add(donation);
    });
  }

  bool replyToggler = false;
  bool addDonationToggler = false;
  bool addDonationBtn = true;

  int currentDonationProposal = 0;

  final _replycontroller = TextEditingController();
  final _donationcontroller = TextEditingController();
  final FocusNode currentNode = FocusNode();
  ScrollController _scrollController = new ScrollController();

  _replyVisibility(int currDonationId) {
    setState(() {
      if (replyToggler == false) {
        replyToggler = true;
        addDonationToggler = false;
        addDonationBtn = false;
        currentDonationProposal = currDonationId;
        print("donation id " + currDonationId.toString());
      } else {
        replyToggler = false;
        addDonationBtn = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _replycontroller.text = "";
    _donationcontroller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Donation")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: width,
          height: height,
          child: BlocProvider(
            create: (context) => MessageBloc(MessageRepo()),
            child: Stack(
              children: <Widget>[
                Container(
                  height: height,
                  child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 26, bottom: 60),
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentDonationProposal = donations[index].id;
                            });
                            print("Current Donaton Proposal " +
                                currentDonationProposal.toString());
                          },
                          child: DonateBubble(
                            id: donations[index].id,
                            donationReplies: donations[index].donationMessages,
                            donationString: donations[index].donationInfo,
                            replyVisibility: _replyVisibility,
                          ),
                        );
                      }),
                ),
                //:::::::::::::::::::::::::::::::::::::::text input field
                replyToggler
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black87
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: TextField(
                              focusNode: currentNode,
                              controller: _replycontroller,
                              maxLines: null,
                              minLines: null,
                              expands: true,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              cursorColor: Theme.of(context).primaryColor,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: null),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {
                                        setState(() {
                                          _replycontroller.text = "";
                                          _replyVisibility(
                                              currentDonationProposal);
                                          addDonationBtn = true;
                                        });

                                        for (int i = 0;
                                            i < donations.length;
                                            i++) {
                                          if (donations[i].id ==
                                              currentDonationProposal) {
                                            setState(() {
                                              donations[i].donationMessages =
                                                  donations[i]
                                                          .donationMessages +
                                                      1;
                                            });
                                          }
                                        }

                                        currentNode.unfocus();
                                      }),
                                  hintText: " Enter reply",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                addDonationToggler
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black87
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          height: 60,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: TextField(
                              focusNode: currentNode,
                              controller: _donationcontroller,
                              maxLines: null,
                              minLines: null,
                              expands: true,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              cursorColor: Theme.of(context).primaryColor,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.message),
                                      onPressed: null),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {
                                        _addDonation(new Donation(
                                            id: donations.length + 1,
                                            donationInfo:
                                                _donationcontroller.text,
                                            donationMessages: 0));
                                        setState(() {
                                          _donationcontroller.clear();
                                          addDonationBtn = true;
                                          addDonationToggler = false;
                                        });
                                        currentNode.unfocus();
                                      }),
                                  hintText: " Write donation proposal",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  height: 20,
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text(
                    "Donation Proposals!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: addDonationBtn
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (addDonationToggler == false) {
                    addDonationToggler = true;
                    replyToggler = false;
                    addDonationBtn = false;
                  } else {
                    addDonationToggler = false;
                    addDonationBtn = true;
                  }
                });
              },
              child: FaIcon(FontAwesomeIcons.commentDots),
            )
          : Container(),
    );
  }
}
