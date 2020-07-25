import 'package:fima/bloc/bloc.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:fima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> myMessages = [
    new Message(admin: false, message: "Test message")
  ];

  final _controller = TextEditingController();
  final FocusNode currentNode = FocusNode();
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();

    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: width,
          height: height,
          child: BlocProvider(
            create: (context) => MessageBloc(MessageRepo()),
            child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
              if (state is MessageInitial) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: height,
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(top: 26, bottom: 60),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return ChatBubble(messages[index]);
                          }),
                    ),
                    //:::::::::::::::::::::::::::::::::::::::text input field
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
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
                            controller: _controller,
                            style: TextStyle(fontWeight: FontWeight.w500),
                            cursorColor: Theme.of(context).primaryColor,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    icon: Icon(Icons.message), onPressed: null),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      BlocProvider.of<MessageBloc>(context)
                                        ..add(AddMessage(new Message(
                                            admin: false,
                                            message: _controller.text)));
                                    }),
                                hintText: " Enter message",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: Text(
                        "Consultation!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              } else if (state is UpdatingMessages) {
                return Container(
                  color: Colors.black,
                  width: width,
                  height: height,
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              } else if (state is MessagesUpdated) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: height,
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(top: 26, bottom: 60),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return ChatBubble(messages[index]);
                          }),
                    ),
                    //:::::::::::::::::::::::::::::::::::::::text input field
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
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
                                    icon: Icon(Icons.message), onPressed: null),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      BlocProvider.of<MessageBloc>(context)
                                        ..add(AddMessage(new Message(
                                            admin: false,
                                            message: _controller.text)));
                                      setState(() {
                                        _controller.text = "";
                                      });
                                      currentNode.unfocus();
                                    }),
                                hintText: " Enter message",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: Text(
                        "Consultation!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text("Am not Good News"),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
