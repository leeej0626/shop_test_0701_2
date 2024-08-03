import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

Widget product_card1(String img_name, String name, String txt, int price,
    int dis_price, int dis_val) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topRight,
        child: off_card(dis_val),
      ),
      Padding(
        padding: EdgeInsets.only(left: 30),
        child: Container(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "asset/product/$img_name.png",
                  width: 80,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: title2_white(
                        name,
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: base_txt(txt, cor: Colors.white)),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          title2_white("\$$dis_price", bold: true),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "\$$price",
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      Container()
    ],
  );
}

Widget off_card(int value) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    decoration:
        BoxDecoration(color: pink5, borderRadius: BorderRadius.circular(5)),
    child: Text(
      "$value% off",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

Widget type_card(String img_name, String txt, bool state) {
  String img_url = "https://twob.fun/test/cake_shop_msg/" + "$img_name";
  return state
      ? Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: pink6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Image.network(
                  img_url,
                  width: 25,
                  height: 25,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                txt,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        )
      : CircleAvatar(
          backgroundColor: pink7,
          radius: 40,
          child: Image.network(
            img_url,
            width: 30,
            height: 30,
          ),
        );
}

Widget page_ind_card(int idx, Function on_click, bool state) {
  return GestureDetector(
    onTap: () {
      on_click();
    },
    child: Container(
      margin: EdgeInsets.only(right: 10),
      height: 50,
      width: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: state ? pink6 : pink1),
      child: Center(
        child: Text(
          "${idx + 1}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
