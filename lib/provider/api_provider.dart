import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/models/sales_rule.dart';

class ApiProvider {
  Client client = Client();

  final _baseUrl = "http://10.0.2.2:8000/";

  Future<List<Product>> fetchProducts() async {
    final response = await client.get(
        "${_baseUrl}products/"); // Make the network call asynchronously to fetch the London weather data.
    /* print(response.body.toString()); */
    if (response.statusCode == 200) {
      //Return decoded response
      print((json.decode(response.body) as List)
          .map((i) => Product.fromJson(i))
          .toList());
      return (json.decode(response.body) as List)
          .map((i) => Product.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load Products');
    }
  }

  Future<List<SalesRule>> fetchSalesRule() async {
    final response = await client.get("${_baseUrl}salesrule/");
    if (response.statusCode == 200) {
      //Return decoded response
      print((json.decode(response.body) as List)
          .map((i) => SalesRule.fromJson(i))
          .toList());
      return (json.decode(response.body) as List)
          .map((i) => SalesRule.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load sales rule');
    }
  }
}
