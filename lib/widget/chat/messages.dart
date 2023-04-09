import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatdocs = snapshot.data!.docs;
        return FutureBuilder(
            future: Future.value(FirebaseAuth.instance.currentUser),
            builder: (context, futuresnapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true,
                itemCount: chatdocs.length,
                itemBuilder: (context, index) {
                  return MessageBubble(chatdocs[index]['text'],
                      futuresnapshot.data!.uid == chatdocs[index]['userId'],chatdocs[index]['userId']);
                },
              );
            });
      },
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
