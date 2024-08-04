import 'package:flutter/cupertino.dart';
import 'package:shop_test_0701/db/cart_db.dart';

import '../api/get_product.dart';
import 'data.dart';

List<cart_data> cart_list = [];

class cart_data {
  late String title;
  late String img_src;
  late int price;
  late int dis_val;
  late int qty;

  cart_data(
      {required this.title,
      required this.img_src,
      required this.price,
      required this.dis_val,
      required this.qty});
}

Future<String> get_product_img_name(String title) async {
  /*List res2 = [];
  List file_list = [
    "birthday_cakes",
    "triangular_cakes",
    "cupcakes_common",
    "fruit_cakes"
  ];
  for (var e in file_list) {
    List res = await get_json_file(e);
    res2.addAll(res);
  }*/
  List product_list = await get_product_api_data();
  String img_name = "";
  product_list.forEach((e) {
    if (title == e["name"]) {
      img_name = e["img_src"];
    }
  });
  String img_src2 = get_img_src(img_name);
  return img_src2;
}

int get_cart_row_count() {
  int qty = 0;
  cart_list.forEach((e) {
    qty += e.qty;
  });
  return qty;
}

String get_product_cart_qty(String title) {
  String qty = "1";
  cart_list.forEach((e) {
    if (e.title == title) {
      qty = e.qty.toString();
    }
  });
  return qty;
}

Future<bool> add_product_cart(String title, int price, int dis_val, int qty,
    String image_name, String num) async {
  var cart_db2 = cart_db();
  //String img_src = await get_product_img_name(title);
  //bool is_exists = false;
  bool is_exists = await cart_db2.get_product_is_exists(title);
  /*cart_list.forEach((e) {
    if (e.title == title) {
      is_exists = true;
      e.qty += qty;
      return;
    }
  });*/

  if (!is_exists) {
    bool r = await cart_db2.add_cart_row(title, image_name, price, 1, qty, num);
    if (r) {
      return true;
    } /*cart_list.add(cart_data(
        title: title,
        img_src: img_src,
        price: price,
        dis_val: dis_val,
        qty: qty));*/
  } else {
    bool r = await cart_db2.add_product_qty(title, qty);
    if (r) {
      return true;
    }
  }
  return false;
}

edit_qty(String title, int qty) async {
  /*cart_list.forEach((e) {
    if (e.title == title) {
      e.qty = qty;
      return;
    }
  });*/
  var cart_db2 = cart_db();
  await cart_db2.edit_product_qty(title, qty);
}

del_produce(String title, Function init) async {
  var cart_db2 = cart_db();
  await cart_db2.remove_product_row(title);
  init();
  //cart_list.removeAt(idx);
}
