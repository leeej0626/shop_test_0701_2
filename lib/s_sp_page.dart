import 'package:flutter/material.dart';
import 'package:shop_test_0701/home_page.dart';

import 'data/data.dart';

class s_sp_page extends StatefulWidget {
  const s_sp_page({super.key});

  @override
  State<s_sp_page> createState() => _s_sp_pageState();
}

class _s_sp_pageState extends State<s_sp_page> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () => to_page(home_page(), context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pink1,
      body: Center(
        child: Image.asset("asset/strawberry-cake.png"),
      ),
    );
  }
}
