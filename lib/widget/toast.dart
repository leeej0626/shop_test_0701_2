import 'package:flutter/material.dart';

enum msg_state { error, success, warn }

void show_msg(
    String title, IconData icons, msg_state state, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(
          icons,
          color: Colors.white,
        ),
        Text(title)
      ],
    ),
    backgroundColor: state == msg_state.error
        ? Colors.redAccent
        : msg_state == msg_state.success
            ? Colors.cyan
            : Colors.orange,
  ));
}
