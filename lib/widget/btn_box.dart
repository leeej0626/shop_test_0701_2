import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/cart_modal.dart';

import '../data/data.dart';

Widget bg_pink_btn(String txt, Function on_clink) {
  return Container(
    height: 45,
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: pink1, elevation: 0),
        onPressed: () => on_clink(),
        child: Text(
          txt,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
  );
}

Widget bg_pick2_btn(String txt, Function on_clink) {
  return Container(
    height: 45,
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: pink2, elevation: 0),
        onPressed: () => on_clink(),
        child: Text(
          txt,
          style: TextStyle(color: pink3, fontSize: 20),
        )),
  );
}

Widget add_btn(Function on_clink) {
  return GestureDetector(
    onTap: () => on_clink(),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: pink5,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
  );
}

Widget reduce_btn(Function on_clink) {
  return GestureDetector(
    onTap: () => on_clink(),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: pink8,
      child: Icon(
        Icons.remove,
        color: pink5,
      ),
    ),
  );
}

Widget qty_box(TextEditingController tec, String title) {
  int qty = int.parse(tec.text);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      reduce_btn(() {
        if (qty > 1) {
          qty--;
          tec.text = qty.toString();
        }
      }),
      Container(
          width: 30,
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: pink6),
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            controller: tec,
            onEditingComplete: () {
              /*if (tec.text.isEmpty) {
                tec.text = "1";
                return;
              }
              if (int.parse(tec.text) > 99) {
                tec.text = "1";
              }*/
            },
          )),
      add_btn(() {
        if (qty < 50) {
          qty++;
          tec.text = qty.toString();
        }
      }),
    ],
  );
}

Widget edit_qty_box(
  TextEditingController tec,
  String title,
  Function on_edit,
) {
  int qty = int.parse(tec.text);
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      reduce_btn(() {
        if (qty > 1) {
          qty--;
          tec.text = qty.toString();
          edit_qty(title, qty);
          on_edit();
        }
      }),
      Container(
          width: 30,
          child: TextField(
            readOnly: true,
            keyboardType: TextInputType.number,
            style: TextStyle(color: pink6),
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            controller: tec,
            onEditingComplete: () {
              /*if (tec.text.isEmpty) {
                tec.text = "1";
                return;
              }
              if (int.parse(tec.text) > 99) {
                tec.text = "1";
              }*/
              on_edit();
            },
          )),
      add_btn(() {
        if (qty < 50) {
          qty++;
          tec.text = qty.toString();
          edit_qty(title, qty);
          on_edit();
        }
      }),
    ],
  );
}

Widget back_btn(BuildContext context, {Color color = Colors.black}) {
  return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: color,
          )));
}
