import 'package:flutter/material.dart';

import '../data/data.dart';

const Color _pink1 = Color(0xffFF9AA2);

Widget title_pink(String txt, {Color color = _pink1}) {
  return Text(
    txt,
    style: TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.bold),
  );
}

Widget title2_white(String txt,
    {bool bold = false, Color color = Colors.white}) {
  return Text(
    txt,
    style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget title3(String txt) {
  return Text(
    txt,
    style: TextStyle(color: grey2, fontSize: 16, fontWeight: FontWeight.bold),
  );
}

Widget base_txt(String txt, {Color cor = Colors.black, bool bold = false}) {
  return Text(
    txt,
    style: TextStyle(
        color: cor, fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget h6(String txt, {Color cor = Colors.black, bool bold = false}) {
  return Text(
    txt,
    style: TextStyle(
        color: cor,
        fontSize: 16,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}

Widget h5(String txt, {Color cor = Colors.black, bool bold = false}) {
  return Text(
    txt,
    style: TextStyle(
        color: cor,
        fontSize: 18,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal),
  );
}
