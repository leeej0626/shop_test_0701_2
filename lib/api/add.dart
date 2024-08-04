import 'package:http/http.dart' as http;

Future<bool> add_ac(String user, String pas, String name) async {
  /*Dio dio = Dio();
    try {
      Response response = await dio.post(
        "https://todoo.5xcamp.us/users",
        data: {"user": {"email":user,"nickname":name,"password":pas},
        },
        options: Options(headers:{
          'Content-Type': 'application/json',
          'accept': 'application/json',
        })
      );
      print(response.data);
      return true;
    } catch (e) {
      if(e is DioError){
        print(e.response?.data);
      }
    }*/
  var url = Uri.parse(
      "https://twob.fun/test/cake_shop_msg/api/add/add_customer.php");
  var rp = await http.post(url, headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: {
    "user": user,
    "name": name,
    "password": pas,
  });
  if (rp.statusCode == 200) {
    return true;
  }
  return false;
}