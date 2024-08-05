import 'dart:math';

import 'package:flutter/material.dart';

import '../data/data.dart';

Widget ipt_box(String title, IconData iconData, TextEditingController tec) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: TextField(
            style: TextStyle(color: pink1),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "輸入$title",
                hintStyle: TextStyle(color: grey2),
                suffix:  Icon(
                  iconData,
                  color: grey2,
                ),
                /*suffixIcon: Icon(
                  iconData,
                  color: grey2,
                )*/),
            controller: tec,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}

Widget serach_ipt_box(TextEditingController tec) {
  return Container(
    height: 50,
    margin: EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Center(
      child: TextField(
        style: TextStyle(color: pink1),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "搜尋",
            hintStyle: TextStyle(color: pink1),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: pink1,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                tec.text = "";
              },
              child: Icon(Icons.close),
            ),
            suffixIconColor: pink1),
        controller: tec,
      ),
    ),
  );
}

Widget password_box(
    String title, TextEditingController tec, Function update_ui, bool eye) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: TextField(
            style: TextStyle(color: pink1),
            onChanged: (val) {
              if (!eye) {
                update_ui();
              }
            },
            obscureText: eye,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title == "再次輸入密碼" ? "請再次輸入密碼" : "輸入$title",
                hintStyle: TextStyle(color: grey2),
                suffixIcon: GestureDetector(
                  onTap: () => update_ui(),
                  child: Icon(
                    eye ? Icons.visibility : Icons.visibility_off,
                    color: grey2,
                  ),
                )),
            controller: tec,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}

