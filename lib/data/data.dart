import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/cart_db.dart';
import '../widget/toast.dart';

Color pink1 = Color(0xffFF9AA2);
Color pink2 = Color(0xffffc5d3);
Color pink3 = Color(0xffFF6572);
Color pink4 = Color(0xffFF6185);
Color pink5 = Color(0xffFF7B99);
Color pink6 = Color(0xffFE4879);
Color pink7 = Color(0xffFEE3EA);
Color pink8 = Color(0xffFFC9D7);
Color pink9 = Color(0xffFE638D);
Color grey = Color(0xffF5F5F5);
Color grey2 = Color(0xff899695);
Color grey3 = Color(0xffF8F8F8);
Color grey4 = Color(0xffA2A6AC);
Color grey5 = Color(0xff798086);

String login_name = "";
String login_user = "";
String login_pass = "";
String login_num = "";
to_page(Widget page, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Future<List> get_json_file(String name) async {
  try {
    String txt = await rootBundle.loadString("asset/json_data/$name.json");
    return jsonDecode(txt);
  } catch (_) {
    return [];
  }
}

close_keyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String get_img_src(String img_name) {
  String img_name2 = img_name.toString().replaceAll("../../", "");
  return "https://twob.fun/test/cake_shop_msg/" + "$img_name2";
}

Future<bool> isNetwork() async {
  try {
    final result = await InternetAddress.lookup("example.com");
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

Future<bool> ch_net(BuildContext context) async {
  if (!await isNetwork()) {
    show_msg("請開啟網路", Icons.wifi, msg_state.warn, context);
    return false;
  }
  return true;
}
