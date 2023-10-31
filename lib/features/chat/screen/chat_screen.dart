import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/features/chat/services/chat_services.dart';
import 'package:amazon_clone_nodejs/features/chat/widgets/card_users_chat.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<User> list = [];

  final ChatServices chatServices = ChatServices();

  @override
  void initState() {
    super.initState();

    fetchListUser();
  }

  void fetchListUser() async {
    list = await chatServices.fetchUsers(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('List Firends'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(3),
          itemBuilder: (context, intdex) {
            final userdata = list[intdex];
            return CardUserChat(model: userdata);
          }),
    );
  }
}
