import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/edit_account_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

import 'api/get_login.dart';

class view_account_page extends StatefulWidget {
  view_account_page({super.key});

  @override
  State<view_account_page> createState() => _view_account_pageState();
}

class _view_account_pageState extends State<view_account_page> {
  @override
  Widget build(BuildContext context) {
    return sfld2(
        Stack(
          children: [
            Column(children: [
              app_bar(context, "帳戶"),
              row("編號", login_num, Icons.numbers),
              row("電子郵件", login_user, Icons.email_outlined),
              row("名稱", login_name, Icons.label),
              row("密碼", get_pass_str(login_pass), Icons.lock),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: bg_pink_btn("編輯", () {
                to_page(edit_account_page(), context);
              }, color: pink6),
            )
          ],
        ),
        context);
  }
}

String get_pass_str(String pass) {
  String s = "";
  for (int i = 0; i < pass.length; i++) {
    s += "*";
  }
  return s;
}

Widget row(String title, String txt, IconData icon) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        base_txt(title, cor: pink1),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15),
                  child: base_txt(txt, cor: pink6)),
              Icon(
                icon,
                color: pink1,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
