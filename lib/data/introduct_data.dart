import 'data.dart';

Future<double> get_product_is_dis(String title) async {
  List res = await get_json_file("cake_data_with_images");
  for(var e in res){
    if (e["name"] == title) {
      return e["discount"];
    }
  }
  return 1;
}
