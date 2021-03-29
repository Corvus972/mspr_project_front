import 'package:flutter/material.dart';
import 'package:mspr_project/screens/profile/orders.dart';
import 'package:mspr_project/repository/user_repository.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
/*     TextButton(onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()));
            } */
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
                      'Edition du profil',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Mettre à jour mon profil',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom utilisateur',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Téléphone',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: addressLine1Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse ligne 1',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: addressLine2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse ligne 2',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: cityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ville',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: zipCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code postal',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Valider'),
                      onPressed: () {
                        userRepository.editUser(
                            usernameController.text,
                            addressLine1Controller.text,
                            addressLine2Controller.text,
                            cityController.text,
                            phoneController.text,
                            zipCodeController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                    )),
              ],
            )));
  }
}
