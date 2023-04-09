import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.instance.subscribeToTopic("all");
  //use of Firebase service without initialization of Firebase core.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.purple,
          accentColor: Colors.indigo,
          accentColorBrightness: Brightness.dark,
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ));
  }
}
