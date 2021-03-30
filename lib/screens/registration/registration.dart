import 'package:flutter/material.dart';
import 'package:mspr_project/repository/user_repository.dart';
import 'package:mspr_project/screens/login/login.dart';
import 'package:mspr_project/widgets/snackbar/snackbar.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey(debugLabel: 'form');

  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Retour'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Créez votre compte sur MSPR shop',
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
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value.length < 10 || value.isEmpty) {
                                  return '10 charactères';
                                }
                                return null;
                              },
                              key: Key('phone'),
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Téléphone',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              validator: (value) {
                                print(isValidEmail(value));
                                if (!isValidEmail(value) || value.isEmpty) {
                                  return 'email non valide';
                                }
                                return null;
                              },
                              key: Key('email'),
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.length < 3 || value.isEmpty) {
                                  return '2 charactères minimum';
                                }
                                return null;
                              },
                              key: Key('pwd'),
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              validator: (value) {
                                if (value.length < 2 || value.isEmpty) {
                                  return '2 charactères minimum';
                                }
                                return null;
                              },
                              key: Key('confirm_password'),
                              obscureText: true,
                              controller: passwordConfirmController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password confirmation',
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  textColor: Colors.black,
                  child: Text('Déjà un compte ? Connectez-vous'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Créer un compte'),
                      key: Key('Register'),
                      onPressed: () async {
                        if (_formKey.currentState.validate() != false) {
                          if (passwordConfirmController.text
                                  .compareTo(passwordController.text) ==
                              0) {
                            var result = await userRepository.registerUser(
                                phoneController.text,
                                emailController.text,
                                passwordController.text);
                            if (result["status"] == 201) {
                              showSnackBar(context, 'Bienvenue !', Colors.blue);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            } else {
                              print(result["body"]["phone_number"]);
                              showSnackBar(context, 'Email déjà utilisé',
                                  Colors.yellow[900]);
                            }
                          } else {
                            showSnackBar(
                                context,
                                'Vos deux mots de passes sont différents',
                                Colors.yellow[900]);
                          }
                        }
                      },
                    )),
              ],
            )));
  }
}
