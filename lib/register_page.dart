import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/login_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

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

  Future<bool> add_ac(String user, String pas,String name) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        "https://todoo.5xcamp.us/users",
        data: {"user": {"email":user,"nickname":name,"password":pas},
        },
        options: Options(headers:{
          'Content-Type': 'application/json',
          'accept': 'application/json',
        })
      );
      print(response.data);
      return true;
    } catch (e) {
      if(e is DioError){
        print(e.response?.data);
      }
    }
    /*var url = Uri.parse("https://todoo.5xcamp.us/api-docs/index.html");

    var rp=await http.post(url, headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    }, body: {
      "user": {"email":user,"nickname":name,"password":pas},
    });
    if(rp.statusCode==200){
      print(rp.body);
      return true;
    }else{
      print(rp.body);
    }*/
    return false;
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
                  bg_pink_btn("註冊", () async{
                    bool b=await add_ac(email_tec.text,pass1_tec.text,name_tec.text);
                    if(b){
                      print("成功");
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
