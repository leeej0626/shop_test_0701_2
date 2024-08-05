import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> get_coupon_list() async {
  var url = Uri.parse(
      "https://twob.fun/test/cake_shop_msg/api/get/get_coupon_json.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "pass": "123",
  });
  if (rp.statusCode == 200) {
    try {
      return jsonDecode(rp.body);
    } catch (e) {
      return [];
    }
  }
  return [];
}
