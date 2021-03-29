import 'package:mspr_project/models/user.dart';
import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class UserRepository {
  ApiProvider _provider = ApiProvider();

  final _userFetcher = PublishSubject<User>();

  Stream<User> get user => _userFetcher.stream;

  Future<String> fetchUser(username, password) async {
    //List<User> userResponse = await _provider.fetchUser();
    //_userFetcher.sink.add(userResponse);
    var user = await _provider.attemptLogIn(username, password);
    return user;
  }

  registerUser(username, phone, email, password) async {
    //List<User> userResponse = await _provider.fetchUser();
    //_userFetcher.sink.add(userResponse);
    var user = await _provider.registerUser(username, phone, email, password);
  }


  editUser(String username, String phone, String addressLine1, String addressLine2,
      String city, String zipCode) async {
    print(phone);
    //List<User> userResponse = await _provider.fetchUser();
    //_userFetcher.sink.add(userResponse);
    var user = await _provider.editUser(username, phone, addressLine1,  addressLine2, city,  zipCode);
  }

  //dispose() {
  // _salesRuleFetcher.close();
  //}
}

final userRepository = UserRepository();
