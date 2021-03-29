import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print("reponse register => " + res.body);
      return res.body;
    }
    print(res.body);
    return null;
  }

  Future<String> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return Future.value(token);
  }

  Future<String> editUser(String username, String phone, String addressLine1,
      String addressLine2, String city, String zipCode) async {
    var token = await isLogged();

    var res = await client.put("${_baseUrl}me/", body: {
      "username": username,
      "phone_number": phone,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "city": city,
      "zipCode": zipCode
    });

    if (res.statusCode == 200) {
      print("reponse register => " + res.body);
      return res.body;
    }

    print(res.body);
    return null;
  }

  Future<bool> sendOrder(Map<String, List> data) async {
    bool rst = false;
    var token = await isLogged();
    var response = await client.post("${_baseUrl}orders/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: json.encode(data));
    if (response.statusCode == 201) {
      rst = true;
    }

    return Future.value(rst);
  }
}
