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
                            child: TextField(
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
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
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
                            child: TextField(
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
                        if (passwordConfirmController.text
                                .compareTo(passwordController.text) ==
                            0) {
                          var result = await userRepository.registerUser(
                              phoneController.text,
                              emailController.text,
                              passwordController.text);
                              print(result["status"]);
                              print(result["body"]);
                              if(result["status"] == 200){
                                 showSnackBar(context, 'Bienvenue !', Colors.blue);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                              }else{
                                print(result["body"]["email"]);
                                print(result["body"]["phone_number"]);
                                showSnackBar(context, 'Une erreur est survenue', Colors.yellow[900]);
                                /* for (var item in result["body"]) {
                                  print(item);
                                  if (result["body"].hasOwnProperty(item)) {
                                    showSnackBar(context, 'Une erreur est survenue', Colors.yellow[900]);
                                  }
                                  
                                } */
                                

                              }
                         
                        }
                      },
                    )),
              ],
            )));
  }
}
