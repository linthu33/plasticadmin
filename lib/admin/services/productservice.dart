import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystore/admin/models/ProductsModel.dart';

import '../constants.dart';

abstract class ProductServiceApi {
  Future<List<ProductsModel>> getProduct();
  Future<int> createProduct(ProductsModel product);
  Future<int> updateProduct(ProductsModel product);
  Future<int> deleteProduct(String productid);
}

class ProductService extends ProductServiceApi {
  @override
  Future<List<ProductsModel>> getProduct() async {
    try {
      var uri = Uri.parse(basicapi + "findAllprod");
      var response =
          await http.get(uri, headers: {"ContentType": "application/json"});

      var resultsObjsJson = jsonDecode(response.body)['product'] as List;
      //print(resultsObjsJson);
      List<ProductsModel> plist = resultsObjsJson
          .map((resultJson) => ProductsModel.fromJson(resultJson))
          .toList();

      //print(plist[0]);
      return plist;
    } catch (err) {
      return List<ProductsModel>.empty();
    }
  }

  @override
  Future<int> createProduct(ProductsModel product) async {
    try {
      var uri = Uri.parse(basicapi + "createprod");
      //Map data = {'title': product.title, 'color': product.color};
      //var prod = jsonEncode(product);
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product),
      );
      print('server response code \t' + response.statusCode.toString());
      return response.statusCode;
    } catch (err) {
      print(err);
      return 0;
    }
  }

  @override
  Future<int> updateProduct(ProductsModel product) async {
    // TODO: implement updateProduct
    try {
      print("updaye ");
      //final pp = product.toJson(product);
      final dd = jsonEncode(product);
      var uri = Uri.parse(basicapi + "editprod");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Accept": "application/json",
      };
      final response = await http.post(uri, headers: headers, body: dd);

      print('serer response code \t' + response.statusCode.toString());
      return response.statusCode;
    } catch (err) {
      return 0;
    }
  }

  @override
  Future<int> deleteProduct(String productid) async {
    // TODO: implement updateProduct
    try {
      print("delete id to servver ");
      print(productid);
      //final pp = product.toJson(product);
      //final dd = jsonEncode(pp);
      var uri = Uri.parse(basicapi + "/deleteprod/$productid");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Accept": "application/json",
      };
      final response = await http.delete(
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
