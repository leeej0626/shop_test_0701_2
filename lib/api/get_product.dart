import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List> get_type_api_data() async {
  var url = Uri.parse(
      "https://twob.fun/test/cake_shop_msg/api/get/get_product_type_json.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "pass": "123"
  });
  if (rp.statusCode == 200) {
    List json_list = jsonDecode(rp.body);
    return json_list;
  }
  return [];
}

Future<List> get_product_api_data() async {
  var url =
      Uri.parse("https://twob.fun/test/cake_shop_msg/api/get/get_product.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "pass": "123"
  });
  if (rp.statusCode == 200) {
    List js_list = jsonDecode(rp.body);
    return js_list;
  }
  return [];
}
