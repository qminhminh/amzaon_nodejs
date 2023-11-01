import 'package:amazon_clone_nodejs/features/chat/models/message_model.dart';
import 'package:amazon_clone_nodejs/helpers/my_date_uitls.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return InkWell(
      onLongPress: () {
        //_showBottomSheet(isMe);
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ListView.builder(
            itemCount: widget.message.chats.length,
            itemBuilder: (context, index) {
              bool isMe =
                  userProvider.user.id == widget.message.chats[index]['fromId'];
              final chatItem = widget.message.chats[index];

              return isMe ? _greenMessage(chatItem) : _blueMessage(chatItem);
            }),
      ),
    );
  }

//isMe ? _greenMessage() : _blueMessage()
  // send or another user message
  Widget _blueMessage(chatItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue),
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Text(
                chatItem['msg'],
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              )),
        ),

        // time
        Padding(
          padding: const EdgeInsets.only(right: 04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: chatItem['sent']),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        // ignore: prefer_const_constructors
        SizedBox(
          width: 4,
        )
      ],
    );
  }

  // our or user message
  Widget _greenMessage(chatItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // time
        Row(
          children: [
            const SizedBox(
              width: 04,
            ),
            if (chatItem['read'].isNotEmpty)
              const Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
                size: 20,
              ),
            const SizedBox(
              width: 2,
            ),
            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: chatItem['sent']),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        // message
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  color: Colors.green.shade50,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Text(
                chatItem['msg'],
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              )),
        ),
      ],
    );
  }

  // botom sheet
  void _showBottomSheet(bool isMe) {
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

              // option COPY TEXT
              _OpionItem(
                  icon: const Icon(
                    Icons.copy_all_rounded,
                    color: Colors.blue,
                    size: 26,
                  ),
                  name: 'Copy Text',
                  onTap: () {
                    // Clipboard.setData(ClipboardData(text: widget.message.msg))
                    //     .then((value) {
                    //   Navigator.pop(context);
                    // });
                  }),
              // option COPY TEXT

              if (isMe)
                const Divider(
                  color: Colors.black54,
                  endIndent: 4,
                  indent: 4,
                ),

              // OPTION EDIT
              if (isMe)
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

              // OPTION DELETE
              if (isMe)
                _OpionItem(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Delete Messgase',
                    onTap: () async {}),

              const Divider(
                color: Colors.black54,
                endIndent: 04,
                indent: 04,
              ),

              // SEND TIME
              // _OpionItem(
              //     icon: const Icon(
              //       Icons.access_time,
              //       color: Colors.blue,
              //       size: 26,
              //     ),
              //     name:
              //         'Send at: ${MyDateUtil.getMessgaeTime(context: context, time: )}',
              //     onTap: () {}),

              // READ TIME
              // _OpionItem(
              //     icon: const Icon(
              //       Icons.remove_red_eye,
              //       color: Colors.blue,
              //       size: 26,
              //     ),
              //     name: widget.message.read.isEmpty
              //         ? 'Read at: Not seen yet'
              //         : 'Read at: ${MyDateUtil.getMessgaeTime(context: context, time: widget.message.read)}',
              //     onTap: () {}),
            ],
          );
        });
  }

  // void _showMessageUpdate() {
  //   // String updatedMsg = widget.message.msg;
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //             contentPadding: const EdgeInsets.only(
  //                 left: 24, right: 24, top: 20, bottom: 10),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20)),
  //             title: const Row(
  //               children: [
  //                 Icon(
  //                   Icons.message,
  //                   color: Colors.blue,
  //                   size: 28,
  //                 ),
  //                 Text('  Update Message')
  //               ],
  //             ),
  //             content: TextFormField(
  //               maxLines: null,
  //               onChanged: (val) => updatedMsg = val,
  //               //onSaved: (val)=> updatedMsg = val!,
  //               initialValue: updatedMsg,
  //               decoration: InputDecoration(
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(15))),
  //             ),
  //             actions: [
  //               MaterialButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   'Cancle',
  //                   style: TextStyle(fontSize: 16, color: Colors.blue),
  //                 ),
  //               ),
  //               MaterialButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text(
  //                   'Update',
  //                   style: TextStyle(fontSize: 16, color: Colors.blue),
  //                 ),
  //               )
  //             ],
  //           ));
  // }
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
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(left: 5, top: 15, bottom: 25),
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
