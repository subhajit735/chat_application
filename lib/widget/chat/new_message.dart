import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class new_message extends StatelessWidget {
  new_message({super.key});
  final controller = new TextEditingController();
  var enteredmessage = "";
  void sendmessage() async{
    // FocusScope.of(context).unfocus();
    // print(enteredmessage);
    final user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredmessage,
      'createdAt':Timestamp.now(),
      'userId':user!.uid,
      
    });
    
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                enteredmessage = value;
              },
              decoration: InputDecoration(labelText: "Send a Message......"),
            ),
          ),
          IconButton(
            onPressed: sendmessage,
            icon: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }
}
