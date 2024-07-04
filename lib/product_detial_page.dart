import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/cart_modal.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

class product_detial_page extends StatefulWidget {
  product_detial_page(this.title, this.txt, this.price, this.img_src,
      {super.key});

  String title;
  String txt;
  String price;
  String img_src;

  @override
  State<product_detial_page> createState() => _product_detial_pageState();
}

class _product_detial_pageState extends State<product_detial_page> {
  TextEditingController qty_tec = TextEditingController();
  String txt2 = "";
  bool is_exp = false;

  @override
  void initState() {
    qty_tec.text = "1";
    txt2 = widget.txt;
    if (txt2.length > 100) {
      txt2 = widget.txt.substring(0, 110) + "...";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: pink7,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      height: 300,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                        child: Column(
                          children: [
                            back_btn(context),
                            Image.asset(
                              "asset/product/${widget.img_src}.png",
                              height: 150,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: title2_white(widget.title, color: Colors.black),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          qty_box(qty_tec, widget.title),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Wrap(
                            children: [
                              base_txt(txt2, cor: grey2),
                              GestureDetector(
                                  onTap: () {
                                    is_exp = !is_exp;
                                    setState(() {
                                      if (is_exp) {
                                        txt2 = widget.txt;
                                      } else {
                                        txt2 = widget.txt.substring(0, 110) +
                                            "...";
                                      }
                                    });
                                  },
                                  child: base_txt(is_exp ? "隱藏" : "閱讀更多",
                                      cor: pink6))
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: pink7),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title2_white(
                          "加入購物車",
                          color: pink6,
                        ),
                        GestureDetector(
                          onTap: () {
                            String title = widget.title;
                            int qty = int.parse(qty_tec.text.toString());
                            // print(qty);
                            add_product_cart(
                                title, int.parse(widget.price), 1, qty);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: pink6,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: title2_white("\$${widget.price}"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
