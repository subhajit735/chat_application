import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/widget/chat/messages.dart';
import 'package:flutter_application_1/widget/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CHAT"), actions: [
        DropdownButton(
          icon: Icon(Icons.more_vert),
          items: [
            DropdownMenuItem(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text("Logout"),
                  ],
                ),
              ),
              value: 'Logout',
            ),
          ],
          onChanged: (value) {
            if (value == 'Logout') {
              FirebaseAuth.instance.signOut();
            }
          },
        )
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            new_message(),
          ],
        ),
      ),
    );
  }
}
