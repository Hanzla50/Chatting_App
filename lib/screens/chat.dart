import 'package:chatting_app/widgets/chat_messages.dart';
import 'package:chatting_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupNotifications() async {
          // for Push notifications
    final fcm = FirebaseMessaging.instance; 
    await fcm.requestPermission(); // It request user permisiion for notification
    final token = await fcm.getToken();   //give address where this app is running
    print(token);  //send this token via (HTTP or Firestore SDK) to a backend
  }

  @override
  void initState() {
    super.initState();
    setupNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: const Column(children: [
        Expanded(
          child: ChatMessages(),
        ),
        NewMessage(),
      ]),
    );
  }
}
