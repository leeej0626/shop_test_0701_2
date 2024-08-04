import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop_test_0701/db/sf_db.dart';
import 'package:shop_test_0701/home_page.dart';
import 'package:shop_test_0701/register_page.dart';
import 'package:shop_test_0701/s_sp_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/toast.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'package:flutter/foundation.dart';
import 'api/get_login.dart';
import 'data/data.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final LocalAuthentication auth = LocalAuthentication();
  TextEditingController email_tec = TextEditingController();
  TextEditingController pass_tec = TextEditingController();
  bool pass_b = true;

  Future<bool> check_ident() async {
    bool r = false;
    try {
      r = await auth.authenticate(
        localizedReason: "請進行身分認證",
        options: AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }
    return r;
  }

  bool check_tec() {
    Map<TextEditingController, String> list_tec = {
      email_tec: "帳號",
      pass_tec: "密碼"
    };
    for (var item in list_tec.entries) {
      var key = item.key;
      var value = item.value;
      if (key.text.isEmpty) {
        show_msg("請輸入${value}", Icons.warning_amber, msg_state.warn, context);
        return false;
      }
    }
    return true;
  }

  /*Future<bool> ch_token(String token) async {
    Dio dio = Dio();
    try {
      Response res = await dio.get("https://todoo.5xcamp.us/check",
          options: Options(headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization":token
          }));
      print(res.data);
      return true;
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
      }
    }
    return false;
  }*/

  void ch_is_login() async {
    String login_u = await get_login_user();
    login_user = login_u;
    if (login_u.isNotEmpty && await check_ident()) {
      init_login_data();
      to_page(s_sp_page(), context);
    }
  }

  void init_login_data() async {
    await set_user(login_user);
    var map = await get_login_data(login_user);
    login_name = map['name'];
    login_num = map['num'];
    login_pass = map['password'];
  }

  void init() async {
    if (!kIsWeb) {
      bool r = await ch_net(context);
      if (r) {
        ch_is_login();
      }
    }
  }

  @override
  void initState() {
    init();
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
    return WillPopScope(
      onWillPop: () async {
        if (login_user.isEmpty) {
          show_msg("請先登入", Icons.warning_amber, msg_state.warn, context);
          return false;
        }
        return true;
      },
      child: sfld(
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
                      bg_pink_btn("登入", () async {
                        if (email_tec.text.isEmpty && pass_tec.text.isEmpty) {
                          email_tec.text = "abc";
                          pass_tec.text = "123";
                        }
                        if (!kIsWeb) {
                          if (!await isNetwork()) {
                            ch_net(context);
                            return;
                          }
                        }
                        bool ch_s = check_tec();
                        if (ch_s) {
                          bool b =
                              await check_login(email_tec.text, pass_tec.text);
                          if (b) {
                            login_user = email_tec.text;
                            login_pass = pass_tec.text;
                            init_login_data();
                            to_page(s_sp_page(), context);
                          } else {
                            show_msg("登入失敗", Icons.warning_amber,
                                msg_state.error, context);
                          }
                        }
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
          context),
    );
  }
}
