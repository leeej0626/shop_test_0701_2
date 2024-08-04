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

Future<String> get_login_user_name(String user) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://twob.fun/test/cake_shop_msg/api/get/get_customer_name.php'));
  request.fields.addAll({'user': 'abc'});
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    print(response.reasonPhrase);
  }
  return "";
}