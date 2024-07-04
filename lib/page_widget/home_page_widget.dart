import 'package:flutter/material.dart';
import 'package:shop_test_0701/account_page.dart';
import 'package:shop_test_0701/data/cart_modal.dart';
import 'package:shop_test_0701/widget/product_card.dart';

import '../cart_page.dart';
import '../data/data.dart';
import '../product_detial_page.dart';
import '../widget/card_box.dart';
import '../widget/ipt_box.dart';

Widget type_card_view(List list, int ind_idx, Function(int) on_clink_btn) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    height: 60,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int idx) {
        String title = "";
        String img_src = "";
        if (idx != 0) {
          title = list[idx - 1]["title"];
          img_src = list[idx - 1]["image_name"];
        }
        bool s = idx == ind_idx;
        return GestureDetector(
          onTap: () => on_clink_btn(idx),
          child: Container(
            width: ind_idx == idx ? 110 : 60,
            margin: EdgeInsets.only(right: 20),
            child: idx == 0
                ? type_card("pie", "全部", s)
                : type_card(img_src, title, s),
          ),
        );
      },
      itemCount: list.length + 1,
    ),
  );
}

Widget product_grid_view(
    List list, BuildContext context, int ind_idx, Function(int) on_click) {
  int list_len = list.length;
  int o_page_q = 6;
  int show_count = 6, s_idx = 0, e_idx = 0;
  int page_qty = (list_len / o_page_q).ceil();
  bool page_mode = list_len > o_page_q;
  if (ind_idx + 1 == page_qty && list_len % o_page_q != 0) {
    e_idx = list_len - 1;
    s_idx = (list_len) - (list_len % 6).ceil();
    show_count = e_idx - s_idx + 1;
  } else {
    e_idx = o_page_q * (ind_idx + 1) - 1;
    s_idx = e_idx - (o_page_q - 1);
  }
  return Container(
    child: Column(
      children: [
        Container(
          height: page_mode ? 270 : 300,
          child: GridView.count(
            childAspectRatio: 0.8,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(page_mode ? show_count : list_len, (index) {
              int idx2 = page_mode ? index + s_idx : index;
              String title = list[idx2]["name"];
              String price = list[idx2]["price"].toString();
              String image_name = list[idx2]["image_name"];
              String description = list[idx2]["description"];
              return GestureDetector(
                  onTap: () {
                    to_page(
                        product_detial_page(
                            title, description, price, image_name),
                        context);
                  },
                  child: product_card_grid(title, image_name, price, () async {
                    await add_product_cart(title, int.parse(price), 1, 1);
                  }));
            }),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        page_mode
            ? Container(
                width: double.infinity,
                height: 30,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(page_qty, (index) {
                        return page_ind_card(index, () {
                          on_click(index);
                        }, index == ind_idx);
                      }),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget product_list_view(
    List list, BuildContext context, int ind_idx, Function(int) on_click) {
  int list_len = list.length;
  int o_page_q = 5;
  int show_count = 5, s_idx = 0, e_idx = 0;
  int page_qty = (list_len / o_page_q).ceil();
  bool page_mode = list_len > o_page_q;
  if (ind_idx + 1 == page_qty && list_len % o_page_q != 0) {
    e_idx = list_len - 1;
    s_idx = (list_len) - (list_len % 5).ceil();
    show_count = e_idx - s_idx + 1;
  } else {
    e_idx = o_page_q * (ind_idx + 1) - 1;
    s_idx = e_idx - (o_page_q - 1);
  }
  return Container(
    child: Column(
      children: [
        Container(
          height: page_mode ? 270 : 300,
          child: ListView.builder(
            itemBuilder: (_, int idx) {
              int idx2 = page_mode ? idx + s_idx : idx;
              String title = list[idx2]["name"];
              String price = list[idx2]["price"].toString();
              String image_name = list[idx2]["image_name"];
              String description = list[idx2]["description"];
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 120,
                child: GestureDetector(
                    onTap: () {
                      to_page(
                          product_detial_page(
                              title, description, price, image_name),
                          context);
                    },
                    child: product_card_list(
                        title, image_name, price, description, () async {
                      await add_product_cart(title, int.parse(price), 1, 1);
                    })),
              );
            },
            itemCount: page_mode ? show_count : list_len,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        page_mode
            ? Container(
                width: double.infinity,
                height: 30,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(page_qty, (index) {
                        return page_ind_card(index, () {
                          on_click(index);
                        }, index == ind_idx);
                      }),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget top_bar(BuildContext context) {
  return Align(
    alignment: Alignment.topRight,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            to_page(cart_page(), context);
          },
          child: Icon(
            Icons.shopping_cart,
            size: 30,
            color: pink5,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            to_page(account_page(), context);
          },
          child: Icon(
            Icons.account_circle_rounded,
            size: 30,
            color: pink5,
          ),
        )
      ],
    ),
  );
}

Widget change_mode(Function grid_btn, Function list_btn) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          grid_btn();
        },
        child: Icon(
          Icons.grid_view_sharp,
          color: grey2,
          size: 30,
        ),
      ),
      SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: () {
          list_btn();
        },
        child: Icon(
          Icons.list,
          color: grey2,
          size: 35,
        ),
      )
    ],
  );
}

Widget serach_bar(TextEditingController tec, Function on_click) {
  return Container(
    child: Row(
      children: [
        Expanded(child: serach_ipt_box(tec)),
        GestureDetector(
          onTap: () => on_click(),
          child: Container(
            margin: EdgeInsets.only(left: 10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: pink4, borderRadius: BorderRadius.circular(8)),
            child: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
