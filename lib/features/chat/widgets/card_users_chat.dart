import 'package:amazon_clone_nodejs/features/chat/screen/chat_message.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:flutter/material.dart';

class CardUserChat extends StatefulWidget {
  final User model;
  const CardUserChat({super.key, required this.model});

  @override
  State<CardUserChat> createState() => _CardUserChatState();
}

class _CardUserChatState extends State<CardUserChat> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatMessages.routeName,
            arguments: widget.model);
      },
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person_2_outlined),
        ),
        title: Text(
          widget.model.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.model.email,
        ),
      ),
    );
  }
}
