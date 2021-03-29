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

  editUser(
      username, phone, email, password, String text, String anotherText) async {
    //List<User> userResponse = await _provider.fetchUser();
    //_userFetcher.sink.add(userResponse);
    var user = await _provider.registerUser(username, phone, email, password);
  }

  //dispose() {
  // _salesRuleFetcher.close();
  //}

}

final userRepository = UserRepository();
