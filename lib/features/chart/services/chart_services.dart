import 'dart:convert';
import 'package:amazon_clone_nodejs/constants/error_handing.dart';
import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/constants/utils.dart';
import 'package:amazon_clone_nodejs/features/chart/model/chart_model.dart';
import 'package:amazon_clone_nodejs/features/chart/provider/chart_provider.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChartServices {
  void createChart({
    required BuildContext context,
    required int money,
  }) async {
    try {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd'); // Định dạng ngày theo ý muốn
      String formattedDate = formatter.format(now);
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/api/chart/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token
        },
        body: jsonEncode({
          "id": userprovider.user.id,
          "money": money,
          "date": formattedDate
        }),
      );
      print(formattedDate);

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // ignore: use_build_context_synchronously
            showSnackBar(context, 'Create chart successful');
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Chart>> getChart({
    required BuildContext context,
  }) async {
    List<Chart> list = [];
    try {
      final userprovider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/api/chart/get/${userprovider.user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // ignore: use_build_context_synchronously
            showSnackBar(context, 'get chart successful');
            final decodeData = jsonDecode(res.body);
            if (decodeData is Map<String, dynamic>) {
              final chartOb = Chart.fromJson(jsonEncode(decodeData));
              list.add(chartOb);
            } else {
              print(
                  'Dữ liệu phản hồi không phải là một đối tượng: $decodeData');
            }
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return list;
  }
}
