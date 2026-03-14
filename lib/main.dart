import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/chat_view.dart';
import 'package:chat_app/view/initial_page.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/view/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const chatApp());
}

class chatApp extends StatelessWidget {
  const chatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        ChatView.id:(context) =>ChatView(),
        InitialPage.id:(context) => InitialPage()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: InitialPage.id,
    );
  }
}
