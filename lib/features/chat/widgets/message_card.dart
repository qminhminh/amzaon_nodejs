import 'package:amazon_clone_nodejs/features/chat/models/message_model.dart';
import 'package:amazon_clone_nodejs/helpers/my_date_uitls.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatefulWidget {
  final Message message;

  const MessageCard({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isMe = userProvider.user.id == widget.message.chats.first['fromId'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          for (final chatItem in widget.message.chats)
            MessageBubble(
              chatItem: chatItem,
              isMe: isMe,
              id: userProvider.user.id,
            ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final dynamic chatItem;
  final bool isMe;
  final String id;

  const MessageBubble(
      {Key? key, required this.chatItem, required this.isMe, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: id == chatItem['fromId']
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: <Widget>[
        if (id == chatItem['fromId'])
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightGreen,
                ),
                color: Colors.green.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Text(
                chatItem['fromId'],
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          )
        else
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.lightBlue,
                ),
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                chatItem['fromId'],
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ),
        const SizedBox(width: 4),
        Text(
          MyDateUtil.getFormattedTime(context: context, time: chatItem['sent']),
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}
