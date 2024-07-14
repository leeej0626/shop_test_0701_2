import 'package:flutter/cupertino.dart';

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
  List res2 = [];
  List file_list = [
    "birthday_cakes",
    "triangular_cakes",
    "cupcakes_common",
    "fruit_cakes"
  ];
  for (var e in file_list) {
    List res = await get_json_file(e);
    res2.addAll(res);
  }
  String img_name = "";
  res2.forEach((e) {
    if (title == e["name"]) {
      img_name = e["image_name"];
    }
  });
  return img_name;
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

Future<void> add_product_cart(
    String title, int price, int dis_val, int qty) async {
  bool is_exists = false;
  cart_list.forEach((e) {
    if (e.title == title) {
      is_exists = true;
      e.qty += qty;
      return;
    }
  });
  String img_src = await get_product_img_name(title);
  if (!is_exists) {
    cart_list.add(cart_data(
        title: title,
        img_src: img_src,
        price: price,
        dis_val: dis_val,
        qty: qty));
  }
}

edit_qty(String title, int qty) {
  cart_list.forEach((e) {
    if (e.title == title) {
      e.qty = qty;
      return;
    }
  });
}

del_produce(int idx) {
  cart_list.removeAt(idx);
}
