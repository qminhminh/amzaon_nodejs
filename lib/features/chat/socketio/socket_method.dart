import 'package:amazon_clone_nodejs/features/chat/socketio/socket_client.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.internal.socket!;

  Socket get socketClient => _socketClient;

  // List<Message> listmess = [];

  // create room chat client
  void createRoomChat(User user, String message, String id) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    if (message.isNotEmpty) {
      _socketClient.emit(
        'createRoomChat',
        {'user': user, 'message': message, "time": time, "id": id},
      );
    }
  }

  void startRoomChat(String toId, BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    // ignore: unnecessary_null_comparison
    if (toId != null && userprovider.user.id != null) {
      _socketClient.emit(
          'startRoomChat', {'toId': toId, 'fromId': userprovider.user.id});
    }
  }
}
