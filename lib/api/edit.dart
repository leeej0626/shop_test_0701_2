import 'package:http/http.dart' as http;

Future<bool> edit_account_data(String user, String pass, String name) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://twob.fun/test/cake_shop_msg/api/edit/edit_account_data.php'));
  request.fields.addAll({'user': user, 'pass': pass, 'name': name});
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    if (await response.stream.bytesToString() == "1") {
      return true;
    }
  } else {
    print(response.reasonPhrase);
  }
  return false;
}
