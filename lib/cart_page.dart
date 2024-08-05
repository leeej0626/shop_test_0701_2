import 'package:flutter/material.dart';
import 'package:shop_test_0701/api/get_coupon.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/db/cart_db.dart';
import 'package:shop_test_0701/home_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/btn_box.dart';
import 'package:shop_test_0701/widget/card_box.dart';
import 'package:shop_test_0701/widget/cart_card.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/toast.dart';
import 'package:shop_test_0701/widget/txt_box.dart';
import 'package:dotted_line/dotted_line.dart';
import 'data/cart_modal.dart';

class cart_page extends StatefulWidget {
  cart_page({super.key});

  @override
  State<cart_page> createState() => _cart_pageState();
}

class _cart_pageState extends State<cart_page> {
  TextEditingController coupon_tec = TextEditingController();
  List<TextEditingController> tec_list = [];
  bool cpi = true;

  var cart_db2 = cart_db();
  int product_amount = 0;
  int ship_amount = 60;
  int cart_amount = 0;
  int dis_amount = 0;
  List<cart_data_modal> db_cart_list = [];
  List coupon_list = [];

  get_cart_amount() {
    product_amount = 0;
    db_cart_list.forEach((e) {
      setState(() {
        product_amount += (e.qty * e.price * e.dis_val).round();
      });
    });
    cart_amount = product_amount + ship_amount - dis_amount;
  }

  /*bool compareDatesOnly(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }*/

  bool today_is_afert(DateTime dt) {
    DateTime today = DateTime.now();
    /*if (compareDatesOnly(today, dt)) {
      return false;
    }
    print(dt);
    print(today.isAfter(dt));*/
    return today.isAfter(dt);
  }

  DateTime parse_date(String date) {
    List<String> parts = date.split('/');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  void init() async {
    coupon_list = await get_coupon_list();
    List<cart_data_modal> list = await cart_db2.get_from_user_cart();
    setState(() {
      db_cart_list = list;
      db_cart_list.forEach((e) {
        tec_list.add(TextEditingController(text: e.qty.toString()));
      });
    });
    get_cart_amount();
    cart_db2.get_user_sum_qty();
    setState(() {
      cpi = false;
    });
  }

  void check_dis_val(String num, int amount) {
    bool is_exists = false;
    coupon_list.forEach((e) {
      if (e["coupon_num"] == num) {
        is_exists = true;
        if (amount >= int.parse(e["min_amount"].toString())) {
          if (today_is_afert(parse_date(e["s_date"]))) {
            if (!today_is_afert(parse_date(e["e_date"]))) {
              setState(() {
                dis_amount = int.parse(e["dis_val"]);
              });
            } else {
              show_msg("優惠券已過期", Icons.warning_amber, msg_state.warn, context);
            }
          } else {
            show_msg("優惠券尚未開始啟用", Icons.warning_amber, msg_state.warn, context);
          }
        } else {
          show_msg("金額不足，尚未達成條件", Icons.warning_amber, msg_state.warn, context);
        }
      }
    });
    if (!is_exists) {
      show_msg("此折扣碼不存在", Icons.warning_amber, msg_state.warn, context);
    }
  }

  @override
  void dispose() {
    for (var tec in tec_list) {
      tec.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: pink6,
      color: Colors.white,
      onRefresh: () async {
        init();
      },
      child: sfld(
        !cpi
            ? Column(
                children: [
                  Container(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: pink6,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: title2_white("購物車", color: pink6),
                        ),
                        db_cart_list.isNotEmpty
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    size: 30,
                                  ),
                                  color: pink6,
                                  onPressed: () async {
                                    cart_db2.clear_list();
                                    init();
                                  },
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  db_cart_list.isNotEmpty && tec_list.isNotEmpty
                      ? Container(
                          height: 400,
                          child: ListView.builder(
                            itemBuilder: (_, int idx) {
                              String title = db_cart_list[idx].title;
                              String price = db_cart_list[idx].price.toString();
                              String qty = db_cart_list[idx].qty.toString();
                              double dis = db_cart_list[idx].dis_val.toDouble();
                              String img_src =
                                  db_cart_list[idx].img_src.toString();
                              TextEditingController tec = tec_list[idx];
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: cart_card(
                                      context, img_src, title, price, qty, () {
                                    setState(() {
                                      del_produce(title, () {
                                        init();
                                        get_cart_amount();
                                      });
                                    });
                                  }, init, dis, tec));
                            },
                            itemCount: db_cart_list.length,
                          ),
                        )
                      : cart_empty_box(context),
                  db_cart_list.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              ipt_coupon_num(coupon_tec, () {
                                check_dis_val(coupon_tec.text, product_amount);
                              }),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 235,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: pink7),
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 10),
                                          child: row_txt(
                                              "總計", product_amount.toString()),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: row_txt(
                                              "運費", ship_amount.toString()),
                                        ),
                                        dis_amount > 0
                                            ? Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 0, 20, 5),
                                                child: row_txt("折扣",
                                                    dis_amount.toString()),
                                              )
                                            : Container(),
                                        DottedLine(
                                          dashColor: pink1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 20, 20),
                                          child: row_txt(
                                              "總金額", cart_amount.toString()),
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
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child:
                                            Center(child: title2_white("結帳")),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              )
            : cpi_box(context),
        context,
      ),
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

Widget ipt_coupon_num(TextEditingController tec, Function btn_oc) {
  return Container(
    height: 45,
    margin: EdgeInsets.only(top: 20),
    decoration:
        BoxDecoration(color: pink7, borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.only(left: 15),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 80, top: 20),
            child: TextField(
              cursorColor: pink6,
              style: TextStyle(color: pink6),
              controller: tec,
              decoration: InputDecoration(
                  /*suffix: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: grey2,
                    ),
                    onPressed: () {
                      tec.text = "";
                    },
                  ),*/
                  hintText: "輸入折扣碼",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: grey2)),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  btn_oc();
                },
                child: Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      color: pink6, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "確定",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    ),
  );
}
