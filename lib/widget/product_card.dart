import 'package:flutter/material.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

import '../data/data.dart';
import 'btn_box.dart';

Widget product_card_grid(
    String title, String img_src, String price, Function add_cart) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  "asset/product/$img_src.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft, child: h6(title, cor: grey2))
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "\$",
                      style: TextStyle(color: grey2),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      price,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )
                  ],
                ),
                add_btn(() {
                  add_cart();
                })
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget product_card_list(
    String title, String img_src, String price, String txt, Function add_cart) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    width: double.infinity,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
                color: pink1, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Image.asset(
                "asset/product/$img_src.png",
                width: 70,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title3(title),
              Container(
                height: 45,
                width: 150,
                child: Text(
                  txt.length > 17 ? txt.substring(0, 17) + "..." : txt,
                  style: TextStyle(color: grey4),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              h6("\$$price", cor: pink4)
            ],
          ),
          add_btn(() {
            add_cart();
          })
        ],
      ),
    ),
  );
}
