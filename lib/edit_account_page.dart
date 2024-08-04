import 'package:flutter/material.dart';
import 'package:shop_test_0701/api/edit.dart';
import 'package:shop_test_0701/view_account_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/toast.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'data/data.dart';

class edit_account_page extends StatefulWidget {
  edit_account_page({super.key});

  @override
  State<edit_account_page> createState() => _edit_account_pageState();
}

class _edit_account_pageState extends State<edit_account_page> {
  TextEditingController user_tec = TextEditingController();
  TextEditingController num_tec = TextEditingController();
  TextEditingController name_tec = TextEditingController();
  TextEditingController pass_tec = TextEditingController();

  @override
  void initState() {
    user_tec.text = login_user;
    name_tec.text = login_name;
    pass_tec.text = login_pass;
    num_tec.text = login_num;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sfld2(
        Stack(
          children: [
            Column(
              children: [
                app_bar(context, "編輯帳號"),
                ipt_box("編號", Icons.numbers, num_tec, read: true),
                ipt_box("電子郵件", Icons.email_outlined, user_tec, read: true),
                ipt_box("名稱", Icons.label, name_tec),
                ipt_box("密碼", Icons.lock, pass_tec)
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bg_pink_btn("儲存", () async {
                bool r = await edit_account_data(
                    user_tec.text, pass_tec.text, name_tec.text);
                login_name = name_tec.text;
                login_pass = pass_tec.text;
                if (r) {
                  to_page(view_account_page(), context);
                } else {
                  show_msg(
                      "編輯失敗", Icons.warning_amber, msg_state.error, context);
                }
              }, color: pink6),
            )
          ],
        ),
        context);
  }
}

Widget row(String title, String txt, IconData icon, TextEditingController tec) {
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
                  child: ipt_box(title, icon, tec)),
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

Widget ipt_box(String title, IconData iconData, TextEditingController tec,
    {bool read = false}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: pink6),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: read ? pink2 : pink7,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: TextField(
              cursorColor: pink6,
              readOnly: read,
              style: TextStyle(color: pink6),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "輸入$title",
                hintStyle: TextStyle(color: pink1),
                suffixIcon: Icon(
                  iconData,
                  color: pink1,
                ),
              ),
              controller: tec,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
