import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/login_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/toast.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'api/add.dart';
import 'api/get_login.dart';

class register_page extends StatefulWidget {
  register_page({super.key});

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  TextEditingController name_tec = TextEditingController();
  TextEditingController email_tec = TextEditingController();
  TextEditingController pass1_tec = TextEditingController();
  TextEditingController pass2_tec = TextEditingController();

  bool check_tec() {
    Map<TextEditingController, String> list_tec = {
      name_tec: "名稱",
      email_tec: "帳號",
      pass1_tec: "密碼"
    };
    for (var item in list_tec.entries) {
      var key = item.key;
      var value = item.value;
      if (key.text.isEmpty) {
        show_msg("請輸入${value}", Icons.warning_amber, msg_state.warn, context);
        return false;
      }
    }
    if (pass1_tec.text != pass2_tec.text) {
      show_msg("密碼須和再次輸入相同", Icons.warning_amber, msg_state.warn, context);
      return false;
    }
    return true;
  }

  bool pass1_b = true;
  bool pass2_b = true;

  @override
  void dispose() {
    name_tec.dispose();
    email_tec.dispose();
    pass1_tec.dispose();
    name_tec.dispose();
    pass2_tec.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sfld(
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: title_pink("註冊"),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ipt_box("名稱", Icons.label, name_tec),
                  ipt_box("電子郵件", Icons.email_outlined, email_tec),
                  password_box("密碼", pass1_tec, () {
                    setState(() {
                      pass1_b = !pass1_b;
                    });
                  }, pass1_b),
                  password_box("再次輸入密碼", pass2_tec, () {
                    setState(() {
                      pass2_b = !pass2_b;
                    });
                  }, pass2_b),
                  SizedBox(
                    height: 20,
                  ),
                  bg_pink_btn("註冊", () async {
                    if (!kIsWeb) {
                      if (!await isNetwork()) {
                        ch_net(context);
                        return;
                      }
                    }
                    bool ch_s = check_tec();
                    bool is_exists = await check_user_is_exists(email_tec.text);
                    if (!ch_s) {
                      return;
                    }
                    if (!is_exists) {
                      show_msg("此帳號已存在", Icons.warning_amber, msg_state.error,
                          context);
                      return;
                    }
                    bool b = await add_ac(
                        email_tec.text, pass1_tec.text, name_tec.text);
                    if (b) {
                      show_msg("註冊成功", Icons.done, msg_state.success, context);
                      Future.delayed(Duration(seconds: 2), () {
                        to_page(login_page(), context);
                      });
                    } else {
                      show_msg("註冊失敗", Icons.warning_amber, msg_state.error,
                          context);
                    }
                  }),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  base_txt("已經有帳號?"),
                  SizedBox(
                    height: 10,
                  ),
                  bg_pick2_btn("登入", () {
                    to_page(login_page(), context);
                  }),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
        context);
  }
}
