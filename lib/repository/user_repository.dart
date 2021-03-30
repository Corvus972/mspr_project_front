import 'package:mspr_project/models/user.dart';
import 'package:mspr_project/provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  ApiProvider _provider = ApiProvider();

  final _userFetcher = PublishSubject<User>();

  Stream<User> get user => _userFetcher.stream;

  bool isLogged = false;

  Future<String> login(username, password) async {
    var rst = await _provider.attemptLogIn(username, password);
    if (rst != null){
      isLogged = true;
    }
    return rst;
  }

  Future<bool> logout()async {
    try{
        final prefs = await SharedPreferences.getInstance();
        prefs.remove("token");
        isLogged = false;
        return true;
    } catch (e){
      print(e);
      return false;

    }
    
  }

  Future<Map> registerUser(phone, email, password) async {
    return await _provider.registerUser(
      {
        "phone_number": phone,
        "email": email,
        "password": password
      });
  }


  Future<bool> editUser(addressLine1, addressLine2, city, phone, zipCode) async {
     return await _provider.editUser(
      {
        "phone_number": phone,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "city": city,
        "zip_code": zipCode
      }
    ); 

  }
  Future<User> getUser() async {
    return await _provider.fetchUserData();
   
  }
  dispose() {
    _userFetcher.close(); // close our StreamController
  }
}

final userRepository = UserRepository();
