import 'package:mystore/admin/constants.dart';
import 'package:mystore/admin/models/orderproductModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class OrderServiceApi {
  Future<List<Orderproduct>> getOrder();
  Future<int> updateOrderStatus(String orderstatus);
}

class OrderService extends OrderServiceApi {
  @override
  Future<List<Orderproduct>> getOrder() async {
    try {
      var uri = Uri.parse(basicapi + "orderfindall");
      var response =
          await http.get(uri, headers: {"ContentType": "application/json"});

      var resultsObjsJson = jsonDecode(response.body)['Order'] as List;
      //print(resultsObjsJson);
      List<Orderproduct> orderlist = resultsObjsJson
          .map((resultJson) => Orderproduct.fromJson(resultJson))
          .toList();

      //print(plist[0]);
      //print(orderlist);
      return orderlist;
    } catch (err) {
      return List<Orderproduct>.empty();
    }
  }

  @override
  Future<int> updateOrderStatus(String orderstatus) async {
    // TODO: implement updateProduct
    try {
      //final pp = product.toJson(product);
      //final dd = jsonEncode(pp);
      var uri = Uri.parse(basicapi + "deleteprod/");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Accept": "application/json",
      };
      final response = await http.put(
        uri,
        headers: headers,
      );

      print('serer response code \t' + response.statusCode.toString());
      return response.statusCode;
    } catch (err) {
      return 0;
    }
  }
}
