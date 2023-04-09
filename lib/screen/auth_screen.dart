import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/widget/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  void submitauthform(
      String email, String username, String password, bool islogin) async {
    try {
      var authresult;
      if (islogin) {
        authresult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(authresult.user.uid)
            .set({'username': username, 'email': email});
      }
    } on PlatformException catch (err) {
      var message = "error occured check credential";
      if (err.message == Null) {
        message = err.message.toString();
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitauthform),
    );
  }
}
