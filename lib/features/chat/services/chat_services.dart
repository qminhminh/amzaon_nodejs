import 'dart:convert';

import 'package:amazon_clone_nodejs/constants/error_handing.dart';
import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/constants/utils.dart';
import 'package:amazon_clone_nodejs/features/chat/models/message_model.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChatServices {
  Future<List<User>> fetchUsers(BuildContext context) async {
    List<User> userlist = [];

    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.get(Uri.parse('$uri/api/chat/users'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userprovider.user.token
      });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userlist.add(User.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return userlist;
  }

  Future<List<Message>> getListMessages(
      BuildContext context, String toId) async {
    List<Message> list = [];

    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      var chatId = getConversationID(userprovider.user.id, toId);
      http.Response res = await http.get(
        Uri.parse('$uri/api/chat/messages/$chatId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              list.add(Message.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }

    return list;
  }

  static String getConversationID(String id1, String id2) {
    String smallerID = id1.hashCode <= id2.hashCode ? id1 : id2;
    String largerID = id1.hashCode <= id2.hashCode ? id2 : id1;
    return '$smallerID-$largerID'; // Sử dụng một định dạng tùy chọn cho chatId
  }
}
