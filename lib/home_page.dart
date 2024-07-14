import 'package:flutter/material.dart';
import 'package:shop_test_0701/cart_page.dart';
import 'package:shop_test_0701/data/cart_modal.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/product_detial_page.dart';
import 'package:shop_test_0701/widget/box.dart';
import 'package:shop_test_0701/widget/card_box.dart';
import 'package:shop_test_0701/widget/dots.dart';
import 'package:shop_test_0701/page_widget/home_page_widget.dart';
import 'package:shop_test_0701/widget/ipt_box.dart';
import 'package:shop_test_0701/widget/product_card.dart';

class home_page extends StatefulWidget {
  home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  TextEditingController serach_tec = TextEditingController();
  List introduce_list = [];
  List type_list = [];
  List current_projuct_list = [];
  int type_ind = 0;
  int indicator_idx = 0;
  int page_sel_idx_list = 0;
  int page_sel_idx_grid = 0;
  int cart_count = 0;
  String ind_img = "", ind_title = "", ind_con = "";
  int ind_off = 0, ind_price = 0, ind_dis_price = 0;
  bool is_swip = false;
  bool grid_mode = true;
  bool serach_empty = false;

  get_introduct_data(int idx) async {
    setState(() {
      ind_img = introduce_list[idx]["image_name"];
      ind_title = introduce_list[idx]["name"];
      ind_con = introduce_list[idx]["description"];
      double off = 1 - double.parse(introduce_list[idx]["discount"].toString());
      ind_off = (off * 101).toInt();
      ind_price = int.parse(introduce_list[idx]["original_price"].toString());
      ind_dis_price = introduce_list[idx]["discounted_price"];
    });
  }

  update_cur_pro_list(int idx) async {
    if (idx == 0) {
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
      setState(() {
        current_projuct_list = res2;
      });
      return;
    }
    String file_name = "";
    switch (idx) {
      case 1:
        file_name = "birthday_cakes";
        break;
      case 2:
        file_name = "triangular_cakes";
        break;
      case 3:
        file_name = "cupcakes_common";
        break;
      case 4:
        file_name = "fruit_cakes";
        break;
    }
    List res = await get_json_file(file_name);
    setState(() {
      current_projuct_list = res;
    });
  }

  init_ind_data() async {
    List res = await get_json_file("cake_data_with_images");
    List res_type = await get_json_file("type_list");
    setState(() {
      introduce_list = res;
      type_list = res_type;
      get_introduct_data(0);
    });
    update_cur_pro_list(0);
  }

  @override
  void initState() {
    init_ind_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return sfld(
        introduce_list.isNotEmpty
            ? Column(
                children: [
                  top_bar(context, cart_count),
                  SizedBox(
                    height: 20,
                  ),
                  serach_bar(serach_tec, () {
                    String serach_txt = serach_tec.text;
                    if (serach_txt.isEmpty) {
                      update_cur_pro_list(type_ind);
                    } else {
                      List res = current_projuct_list;
                      setState(() {
                        current_projuct_list = res.where((e) {
                          return e["name"].toString().contains(serach_txt) ||
                              e["price"].toString().contains(serach_txt) ||
                              e["description"].toString().contains(serach_txt);
                        }).toList();
                        if (current_projuct_list.isEmpty) {
                          serach_empty = true;
                        } else {
                          serach_empty = false;
                        }
                      });
                    }
                    close_keyboard(context);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onHorizontalDragStart: (de) {
                      is_swip = false;
                    },
                    onHorizontalDragEnd: (de) {
                      is_swip = false;
                    },
                    onHorizontalDragUpdate: (detail) {
                      int sens = 8;
                      if (is_swip) return;
                      if (detail.delta.dx > sens) {
                        if (indicator_idx > 0) {
                          setState(() {
                            indicator_idx--;
                            get_introduct_data(indicator_idx);
                          });
                        }
                        is_swip = true;
                      } else if (detail.delta.dx < -sens) {
                        if (indicator_idx < introduce_list.length - 1) {
                          setState(() {
                            indicator_idx++;
                            get_introduct_data(indicator_idx);
                          });
                        }
                        is_swip = true;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                          color: pink4, borderRadius: BorderRadius.circular(8)),
                      child: Stack(children: [
                        product_card1(ind_img, ind_title, ind_con, ind_price,
                            ind_dis_price, ind_off),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  List.generate(introduce_list.length, (index) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indicator_idx = index;
                                        get_introduct_data(index);
                                      });
                                    },
                                    child: dots(index == indicator_idx));
                              }),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  change_mode(() {
                    setState(() {
                      grid_mode = true;
                    });
                  }, () {
                    setState(() {
                      grid_mode = false;
                    });
                  }),
                  type_card_view(type_list, type_ind, (int idx) {
                    setState(() {
                      type_ind = idx;
                      update_cur_pro_list(idx);
                    });
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  current_projuct_list.isNotEmpty
                      ? grid_mode
                          ? product_grid_view(
                              current_projuct_list, context, page_sel_idx_grid,
                              (idx) {
                              setState(() {
                                page_sel_idx_grid = idx;
                              });
                            }, () {
                              setState(() {
                                cart_count = get_cart_row_count();
                              });
                            })
                          : product_list_view(
                              current_projuct_list, context, page_sel_idx_list,
                              (idx) {
                              setState(() {
                                page_sel_idx_list = idx;
                              });
                            }, () {
                              setState(() {
                                cart_count = get_cart_row_count();
                              });
                            })
                      : !serach_empty
                          ? cpi_box()
                          : empty_box(Icons.search_off_outlined, "查無商品"),
                ],
              )
            : Container(
                child: cpi_box(),
              ),
        context,
        bg: grey3);
  }
}
