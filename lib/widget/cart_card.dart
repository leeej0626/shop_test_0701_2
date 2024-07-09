import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/cart_modal.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

import '../data/data.dart';
import 'btn_box.dart';

Widget cart_card(BuildContext context, String img_src, String title,
    String price, String qty, Function on_del, Function on_edit_qty) {
  ScrollController sro_col = ScrollController();
  TextEditingController qty_tec = TextEditingController();
  qty_tec.text = qty;
  bool dis_mode = false;
  scroll_to_top() {
    if (sro_col.hasClients) {
      sro_col.jumpTo(0);
    }
    /*sro_col.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.easeInOut);*/
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      controller: sro_col,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: pink7),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Image.asset(
                                "asset/product/$img_src.png",
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(child: h6(title, cor: grey5)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    h6("\$$price", cor: pink6, bold: true),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    dis_mode
                                        ? Text(
                                            "\$3000",
                                            style: TextStyle(
                                                color: grey2,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        : Container()
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: edit_qty_box(
                          qty_tec,
                          title,
                          () => on_edit_qty(),
                        ))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              on_del();
              scroll_to_top();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 120,
                width: 90,
                color: pink6,
                /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: pink6),*/
                child: Center(
                  child: Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    ),
  );
}
