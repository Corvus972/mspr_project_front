import 'dart:async';

class AuthService {
  
  final authStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => authStreamController.stream;

  bool isLogged = false;

  set setLogged(bool logged) {
    isLogged = logged;
  }
  bool get getLogged  {
    return isLogged;
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree

  void dispose() {
    authStreamController.close(); // close our StreamController
  }
}

final authService = AuthService();
