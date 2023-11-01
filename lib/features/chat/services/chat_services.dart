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

      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body);
        if (decodedData is Map<String, dynamic>) {
          final chatObject = Message.fromJson(jsonEncode(decodedData));
          list.add(chatObject);
        } else {
          // In ra thông báo lỗi nếu dữ liệu phản hồi không phải là một đối tượng.
          print('Dữ liệu phản hồi không phải là một đối tượng: $decodedData');
        }
      } else {
        // Xử lý lỗi HTTP status code khác 200 ở đây
        print('Mã trạng thái Phản hồi HTTP: ${res.statusCode}');
      }
      print('HTTP Response Status Code: ${res.statusCode}');
      print('HTTP Response Body: ${res.body}');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    print(list.length);

    return list;
  }

  static String getConversationID(String id1, String id2) {
    String smallerID = id1.hashCode <= id2.hashCode ? id1 : id2;
    String largerID = id1.hashCode <= id2.hashCode ? id2 : id1;
    return '${largerID}_$smallerID'; // Sử dụng một định dạng tùy chọn cho chatId
  }

  void updateMessage({
    required String toId,
    required String send,
    required BuildContext context,
  }) async {
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);

      final time = DateTime.now().millisecondsSinceEpoch.toString();
      http.Response res = await http.put(
        Uri.parse('$uri/api/chat/messages/update'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({'toId': toId, 'read': time, 'send': send}),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'update success');
            print(res);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
