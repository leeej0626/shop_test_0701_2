import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> check_login(String user, String pass) async {
  var url = Uri.parse(
      "https://twob.fun/test/cake_shop_msg/api/get/check_customer_login.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "user": user,
    "pass": pass
  });
  if (rp.statusCode == 200) {
    if (rp.body == "1") {
      return true;
    }
  }
  return false;
}

Future<bool> check_user_is_exists(String user) async {
  var url = Uri.parse(
      "https://twob.fun/test/cake_shop_msg/api/get/check_user_is_exists.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "user": user,
  });
  if (rp.statusCode == 200) {
    if (rp.body == "1") {
      return true;
    }
  }
  return false;
}

Future<Map<String, dynamic>> get_login_data(String user) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://twob.fun/test/cake_shop_msg/api/get/get_customer_data.php'));
  request.fields.addAll({'user': user});
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    Map<String, dynamic> js_data =
        jsonDecode(await response.stream.bytesToString());
    return js_data;
  } else {
    print(response.reasonPhrase);
  }
  return {};
}
