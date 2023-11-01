import 'package:amazon_clone_nodejs/features/chat/models/message_model.dart';
import 'package:amazon_clone_nodejs/helpers/my_date_uitls.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              context: context,
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
  final BuildContext context;

  const MessageBubble(
      {Key? key,
      required this.chatItem,
      required this.isMe,
      required this.id,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showBottomSheet(chatItem, id);
      },
      child: Row(
        mainAxisAlignment: id == chatItem['fromId']
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          id == chatItem['fromId'] ? _greenMessage() : _blueMessage(),
          const SizedBox(width: 4),
          Text(
            MyDateUtil.getFormattedTime(
                context: context, time: chatItem['sent']),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _greenMessage() {
    return Flexible(
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
          chatItem['msg'],
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _blueMessage() {
    return Flexible(
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
          chatItem['msg'],
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ),
    );
  }

  void _showBottomSheet(dynamic chatItem, String id) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
              _OpionItem(
                  icon: const Icon(
                    Icons.copy_all_rounded,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name: 'Copy Text',
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: chatItem['msg']))
                        .then((value) {
                      Navigator.pop(context);
                    });
                  }),
              const Divider(
                color: Colors.black54,
                endIndent: 4,
                indent: 4,
              ),
              if (id == chatItem['fromId'])
                _OpionItem(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Edit Message',
                    onTap: () {
                      Navigator.pop(context);
                      //_showMessageUpdate();
                    }),
              if (id == chatItem['fromId'])
                _OpionItem(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name: 'Delete Messgase',
                  onTap: () {},
                ),
              if (id == chatItem['fromId'])
                const Divider(
                  color: Colors.black54,
                  endIndent: 4,
                  indent: 4,
                ),
              _OpionItem(
                  icon: const Icon(
                    Icons.access_time,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name:
                      'Send at: ${MyDateUtil.getMessgaeTime(context: context, time: chatItem['sent'])}',
                  onTap: () {}),
              _OpionItem(
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name: chatItem['read'].isEmpty
                      ? 'Read at: Not seen yet'
                      : 'Read at: ${MyDateUtil.getMessgaeTime(context: context, time: chatItem['read'])}',
                  onTap: () {}),
            ],
          );
        });
  }
}

class _OpionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;
  const _OpionItem(
      {required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 15, bottom: 25),
        child: Row(
          children: [
            icon,
            Flexible(
                child: Text(
              '    $name',
              style: const TextStyle(
                fontSize: 15,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
