import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_test_0701/data/data.dart';

class cart_db {
  final ValueNotifier<int> cart_sum_qty = ValueNotifier<int>(0);

  cart_db() {
    get_user_sum_qty();
  }

  String cart_list_key = "cart_list";

  Future<bool> add_cart_row(String title, String img_src, int price,
      int dis_val, int qty, String num) async {
    final sf = await SharedPreferences.getInstance();
    List<String> list = await get_all_row();
    cart_data_modal row = cart_data_modal(
        title: title,
        img_src: img_src,
        price: price,
        dis_val: dis_val,
        qty: qty,
        num: num,
        user: login_user);
    String row_json = jsonEncode(row.to_json());
    list.add(row_json);
    sf.setStringList(cart_list_key, list);
    return true;
  }

  Future<bool> get_product_is_exists(String title) async {
    List<cart_data_modal> list = await get_from_user_cart();
    for (var row in list) {
      if (row.user == login_user && row.title == title) {
        return true;
      }
    }
    return false;
  }

  Future<bool> add_product_qty(String title, int qty) async {
    final sf = await SharedPreferences.getInstance();
    List<String> r_list = [];
    List<cart_data_modal> list = await get_from_user_cart();
    for (var row in list) {
      if (row.user == login_user && row.title == title) {
        row.qty += qty;
      }
    }
    list.forEach((e) {
      r_list.add(jsonEncode(e.to_json()));
    });
    sf.setStringList(cart_list_key, r_list);
    return true;
  }

  void get_user_sum_qty() async {
    int qty = 0;
    List<cart_data_modal> list = await get_from_user_cart();
    for (var row in list) {
      if (row.user == login_user) {
        qty += row.qty;
      }
    }
    cart_sum_qty.value = qty;
  }

  Future<bool> remove_product_row(String title) async {
    final sf = await SharedPreferences.getInstance();
    List<String> r_list = [];
    List<cart_data_modal> list = await get_from_user_cart();
    list.removeWhere((e) => e.user == login_user && e.title == title);
    list.forEach((e) {
      r_list.add(jsonEncode(e.to_json()));
    });
    sf.setStringList(cart_list_key, r_list);
    return true;
  }

  Future<bool> edit_product_qty(String title, int qty) async {
    final sf = await SharedPreferences.getInstance();
    List<String> r_list = [];
    List<cart_data_modal> list = await get_from_user_cart();
    for (var row in list) {
      if (row.user == login_user && row.title == title) {
        row.qty = qty;
      }
    }
    list.forEach((e) {
      r_list.add(jsonEncode(e.to_json()));
    });
    sf.setStringList(cart_list_key, r_list);
    return true;
  }

  Future<bool> clear_list() async {
    final sf = await SharedPreferences.getInstance();
    await sf.setStringList(cart_list_key, []);
    return true;
  }

  Future<List<cart_data_modal>> get_from_user_cart() async {
    List<String> list = await get_all_row();
    List<cart_data_modal> r_list = [];
    list.forEach((e) {
      Map<String, dynamic> row = jsonDecode(e);
      String title = row["title"];
      String img_src = row["img_src"];
      String num = row["num"];
      String user = row["user"];
      int price = row["price"];
      int qty = row["qty"];
      int dis_val = row["dis_val"];
      r_list.add(cart_data_modal(
          title: title,
          img_src: img_src,
          price: price,
          dis_val: dis_val,
          qty: qty,
          num: num,
          user: user));
    });
    return r_list.where((e) {
      return e.user == login_user;
    }).toList();
  }

  Future<List<String>> get_all_row() async {
    final sf = await SharedPreferences.getInstance();
    return sf.getStringList(cart_list_key) ?? [];
  }
}

class cart_data_modal {
  late String title;
  late String img_src;
  late int price;
  late int dis_val;
  late int qty;
  late String num;
  late String user;

  cart_data_modal(
      {required this.title,
      required this.img_src,
      required this.price,
      required this.dis_val,
      required this.qty,
      required this.num,
      required this.user});

  Map<String, dynamic> to_json() => {
        "title": title,
        "img_src": img_src,
        "price": price,
        "dis_val": dis_val,
        "qty": qty,
        "num": num,
        "user": user,
      };
}
