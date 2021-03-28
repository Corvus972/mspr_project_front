class Token {
  String refresh;
  String access;
  int userId;
  bool superUser;

  Token({this.refresh, this.access, this.userId, this.superUser});
  factory Token.fromJson(Map<String, dynamic> responseData) {
    return Token(
        refresh: responseData['refresh'],
        access: responseData['access'],
        userId: responseData['user_id'],
        superUser: responseData['superUser']);
  }
  get getRefresh => this.refresh;

  set setRefresh(refresh) => this.refresh = refresh;

  get getAccess => this.access;

  set setAccess(access) => this.access = access;
}
