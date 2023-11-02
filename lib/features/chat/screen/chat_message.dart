import 'package:amazon_clone_nodejs/common/widgets/loader.dart';
import 'package:amazon_clone_nodejs/features/chat/models/message_model.dart';
import 'package:amazon_clone_nodejs/features/chat/services/chat_services.dart';
import 'package:amazon_clone_nodejs/features/chat/socketio/socket_client.dart';
import 'package:amazon_clone_nodejs/features/chat/socketio/socket_method.dart';
import 'package:amazon_clone_nodejs/features/chat/widgets/message_card.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:async';

class ChatMessages extends StatefulWidget {
  static const String routeName = "/chat_messages";
  final User model;
  const ChatMessages({super.key, required this.model});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final textController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  List<Message>? _list;
  final ChatServices _chatServices = ChatServices();
  final _socketClient = SocketClient.internal.socket!;
  Socket get socketClient => _socketClient;
  late Timer _timer;

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    fechListMessage();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      fetchAndSetListMessages();
    });
  }

  void fechListMessage() async {
    _list = await _chatServices.getListMessages(context, widget.model.id);
    setState(() {});
  }

  void fetchAndSetListMessages() async {
    final messages =
        await _chatServices.getListMessages(context, widget.model.id);
    setState(() {
      _list = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                widget.model.email,
                style: const TextStyle(fontSize: 13),
              ),
            ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: _list == null
                ? const Loader()
                : _list!.isEmpty
                    ? const Center(child: Text('No messages available'))
                    : ListView.builder(
                        itemCount: _list!.length,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 10),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, intdex) {
                          return MessageCard(
                            message: _list![intdex],
                          );
                        }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.blueAccent,
                            size: 25,
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          controller: textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onTap: () {},
                          decoration: const InputDecoration(
                              hintText: 'Type...',
                              hintStyle: TextStyle(color: Colors.blueAccent),
                              border: InputBorder.none),
                        )),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.image,
                            color: Colors.blueAccent,
                            size: 26,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.blueAccent,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      // create chat
                      _socketMethods.createRoomChat(widget.model,
                          textController.text, userProvider.user.id);
                      // create sucess
                      _socketClient.on('createRoomChatSuccess', (data) {
                        Future.delayed(const Duration(seconds: 1), () {
                          fechListMessage();
                        });
                      });
                      textController.text = '';
                    }
                  },
                  minWidth: 0,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 5, left: 10),
                  shape: const CircleBorder(),
                  color: Colors.lightBlueAccent,
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
