import 'package:flutter/material.dart';
import 'package:mspr_project/repository/user_repository.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mspr_project/widgets/snackbar/snackbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MSPR'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Connectez-vous',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    child: Form(
                        key: _formKey,
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  key: Key('email'),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  key: Key('pwd'),
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Mot de passe',
                                  ),
                                ),
                              ),
                            ]))),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.black,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Login'),
                      key: Key('login'),
                      onPressed: () async {
                        var jwt = await getTokenFromLogin(
                            emailController.text, passwordController.text);
                        if (jwt != null) {
                          // obtain shared preferences
                          final prefs = await SharedPreferences.getInstance();
                          // set value on secure storage
                          prefs.setString('token', jwt);
                          showSnackBar(context, 'Vous êtes connecté', Colors.blue);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else if (emailController.text == '' ||
                            passwordController.text == '') {
                          showSnackBar(context, 'Champ vide detecté', Colors.yellow[900]);
                        } else {
                          showSnackBar(context, 'Identifiants incorrect', Colors.yellow[900]);
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.black,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  Future<String> getTokenFromLogin(String email, String password) async {
    var response = await userRepository.login(email, password);
    return Future.value(response);
  }
}
