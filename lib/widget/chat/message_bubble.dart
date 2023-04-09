import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      @required this.message, @required this.isMe, @required this.userid);
  String message;
  bool isMe;
  String userid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(13),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(13),
            ),
          ),
          width: 100,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(userid)
                    .get(),
                builder: (context, futuresnapshot) {
                  if (futuresnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text("Loading........");
                  }
                  // print(futuresnapshot.data!['username']);
                  
                  return Text(futuresnapshot.data!['username']);
                },
              ),
              Text(
                message,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentTextTheme.titleLarge!.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
