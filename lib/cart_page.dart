import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/home_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/card_box.dart';
import 'package:shop_test_0701/widget/cart_card.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'package:dotted_line/dotted_line.dart';
import 'data/cart_modal.dart';

class cart_page extends StatefulWidget {
  cart_page({super.key});

  @override
  State<cart_page> createState() => _cart_pageState();
}

class _cart_pageState extends State<cart_page> {
  int product_amount = 0;
  int ship_amount = 60;
  int cart_amount = 0;

  get_cart_amount() {
    product_amount = 0;
    cart_list.forEach((e) {
      setState(() {
        product_amount += e.qty * e.price;
      });
    });
    cart_amount = product_amount + ship_amount;
  }

  @override
  void initState() {
    get_cart_amount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sfld(
      Column(
        children: [
          Stack(
            children: [
              back_btn(context),
              Align(
                alignment: Alignment.center,
                child: title2_white("購物車", color: Colors.black),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          cart_list.isNotEmpty
              ? Container(
                  height: 400,
                  child: ListView.builder(
                    itemBuilder: (_, int idx) {
                      String title = cart_list[idx].title;
                      String price = cart_list[idx].price.toString();
                      String qty = cart_list[idx].qty.toString();
                      String img_src = cart_list[idx].img_src.toString();
                      return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: cart_card(context, img_src, title, price, qty,
                              () {
                            setState(() {
                              del_produce(idx);
                              get_cart_amount();
                            });
                          }, get_cart_amount));
                    },
                    itemCount: cart_list.length,
                  ),
                )
              : cart_empty_box(context),
          cart_list.isNotEmpty
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: pink7),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: row_txt("總計", product_amount.toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: row_txt("運費", ship_amount.toString()),
                            ),
                            DottedLine(
                              dashColor: pink1,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                              child: row_txt("總金額", cart_amount.toString()),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: pink6,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(child: title2_white("結帳")),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
      context,
    );
  }
}

Widget row_txt(String title, String price) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        h5(title, cor: grey5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$",
              style: TextStyle(fontSize: 12, color: pink6),
            ),
            SizedBox(
              width: 5,
            ),
            h6(price, cor: pink6, bold: true)
          ],
        )
      ],
    ),
  );
}

Widget cart_empty_box(BuildContext context) {
  return Container(
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        empty_box(Icons.shopping_cart_outlined, "您的購物車尚無商品"),
        SizedBox(
          height: 20,
        ),
        bg_pink_btn("前往購物", () {
          to_page(home_page(), context);
        })
      ],
    ),
  );
}
