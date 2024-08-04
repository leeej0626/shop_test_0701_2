import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shop_test_0701/account_page.dart';
import 'package:shop_test_0701/cart_page.dart';
import 'package:shop_test_0701/home_page.dart';
import 'package:shop_test_0701/login_page.dart';
import 'package:shop_test_0701/s_sp_page.dart';
import 'package:shop_test_0701/view_account_page.dart';

void main() {
  runApp(MaterialApp(
    scrollBehavior: cus_scroll(),
    theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    home: login_page(),
  ));
}

class cus_scroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}