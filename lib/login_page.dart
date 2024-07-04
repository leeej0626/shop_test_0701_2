import 'package:flutter/material.dart';
import 'package:shop_test_0701/home_page.dart';
import 'package:shop_test_0701/register_page.dart';
import 'package:shop_test_0701/s_sp_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

import 'data/data.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController email_tec = TextEditingController();
  TextEditingController pass_tec = TextEditingController();
  bool pass_b = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email_tec.dispose();
    pass_tec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return sfld(
        Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: title_pink("登入"),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ipt_box("電子郵件", Icons.email_outlined, email_tec),
                    password_box("密碼", pass_tec, () {
                      setState(() {
                        pass_b = !pass_b;
                      });
                    }, pass_b),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: GestureDetector(
                              onTap: () {},
                              child: base_txt("忘記密碼?", cor: pink1))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    bg_pink_btn("登入", () {
                      to_page(s_sp_page(), context);
                    })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    base_txt("還沒有帳號?"),
                    SizedBox(
                      height: 10,
                    ),
                    bg_pick2_btn("註冊", () {
                      to_page(register_page(), context);
                    })
                  ],
                ),
              ),
            )
          ],
        ),
        context);
  }
}
