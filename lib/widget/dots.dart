import 'package:flutter/material.dart';

import '../data/data.dart';

Widget dots(bool state) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    child: state == false
        ? CircleAvatar(
      backgroundColor: Colors.white,
      radius: 7,
      child: CircleAvatar(
        backgroundColor: pink4,
        radius: 6,
      ),
    )
        : CircleAvatar(
      backgroundColor: Colors.white,
      radius: 7,
    ),
  );
}