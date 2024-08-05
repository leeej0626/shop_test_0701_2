import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/db/sf_db.dart';
import 'package:shop_test_0701/login_page.dart';
import 'package:shop_test_0701/view_account_page.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

class account_page extends StatefulWidget {
  account_page({super.key});

  @override
  State<account_page> createState() => _account_pageState();
}

class _account_pageState extends State<account_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pink6,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              back_btn(context, color: Colors.white),
              SizedBox(
                height: 30,
              ),
              title2_white(login_name),
              SizedBox(
                height: 10,
              ),
              h6(login_user, cor: Colors.white),
              SizedBox(
                height: 20,
              ),
              btn_row("查看帳號", Icons.account_circle, () {
                to_page(view_account_page(), context);
              }),
              btn_row("查看訂單", Icons.list, () {}),
              out_btn_row(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget btn_row(String title, IconData iconData, Function on_click) {
  return GestureDetector(
    onTap: () => on_click(),
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: pink9),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Widget out_btn_row(BuildContext context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 20),
    child: GestureDetector(
      onTap: () async {
        login_user = "";
        login_name = "";
        await set_user("");
        to_page(login_page(), context);
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.output,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "登出",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ),
  );
}
