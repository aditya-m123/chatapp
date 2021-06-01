import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';

final _firestore = FirebaseFirestore.instance;
late final User logginInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_Screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  //check if User is logged In?
  late String message;
  final messageTextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        logginInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void getUpdatedmessages() async {
    await for (var messages in _firestore.collection('messages').snapshots()) {
      for (var message in messages.docs) {
        print(message.data().cast());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //   automaticallyImplyLeading: false,

        ///Hide back button
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(
                    context, WelcomeScreen.id); //Go back to Main screen
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextcontroller,
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextcontroller.clear();
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': logginInUser.email,
                        'time': FieldValue.serverTimestamp()
                      });
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send data',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('time')
          .snapshots(), //calling firebase collection
      builder: (context, snapshot) {
        List<MessageBubble> messagesWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var latest_message in messages) {
          final message_Text = latest_message['text'];
          final message_Sender = latest_message['sender'];

          final currentUser = logginInUser.email;

          final message_Widget = MessageBubble(
              text: message_Text,
              sender: message_Sender,
              isMe: currentUser == message_Sender);
          messagesWidgets.add(message_Widget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messagesWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender, required this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender', style: TextStyle(color: Colors.grey, fontSize: 12)),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5.0,
            color: isMe ? Colors.purple : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
