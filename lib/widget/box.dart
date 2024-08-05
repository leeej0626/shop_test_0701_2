import 'package:flutter/material.dart';
import 'package:shop_test_0701/data/data.dart';
import 'package:shop_test_0701/widget/txt_box.dart';

Widget sfld(Widget content, BuildContext context, {Color bg = Colors.white}) {
  return Scaffold(
    backgroundColor: bg,
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: content,
        ),
      ),
    ),
  );
}

Widget sfld2(Widget content, BuildContext context, {Color bg = Colors.white}) {
  return Scaffold(
    backgroundColor: bg,
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: content,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

const Color _pink5 = Color(0xFFE91E63);

Widget cpi_box(BuildContext context, {Color color = _pink5}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    ),
  );
}

Widget empty_box(IconData iconData, String txt) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: pink5,
          size: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          txt,
          style: TextStyle(color: pink5),
        )
      ],
    ),
  );
}

Widget app_bar(BuildContext context, String title) {
  return Stack(
    alignment: Alignment.center,
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
            size: 30,
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: title_pink(title, color: pink4),
      )
    ],
  );
}
