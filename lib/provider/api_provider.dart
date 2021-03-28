import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/models/token.dart';

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
      return (json.decode(response.body) as List)
          .map((i) => SalesRule.fromJson(i))
          .toList();
    } else {
      throw Exception('Failed to load sales rule');
    }
  }

  Future<String> fetchSaleProduct(String idProduct) async {
    final response = await client.get("${_baseUrl}ruleproduct/" + idProduct);
    String couponResponse;
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      couponResponse = data[0]['coupon_code'].toString() +
          " " +
          "associé à " +
          data[0]['name'];
    } else {
      throw Exception('Failed to load Rule for product');
    }
    return couponResponse;
  }

  Future<String> attemptLogIn(String username, String password) async {
    var res = await client.post("${_baseUrl}login/",
        body: {"email": username, "password": password});
    if (res.statusCode == 200) {
      var token = Token.fromJson(json.decode(res.body));
      return token.access;
    } else {
      throw Exception('Failed to credential');
    }
  }

  Future<String> registerUser(
      String username, String phone, String email, String password) async {
    var res = await client.post("${_baseUrl}users/", body: {
      "email": email,
      "username": username,
      "phone_number": phone,
      "password": password
    });
    if (res.statusCode == 200) {
      print("reponse register =>" + res.body);
      return res.body;
    }
    print(res.body);
    return null;
  }
}
