import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatefulWidget {
  static const String routeName = "/chat_messages";
  final User model;
  const ChatMessages({super.key, required this.model});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            widget.model.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            widget.model.email,
          ),
        ]),
      ),
    );
  }
}
