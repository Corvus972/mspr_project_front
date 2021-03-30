import 'package:flutter/material.dart';
import 'package:mspr_project/screens/profile/orders.dart';
import 'package:mspr_project/repository/user_repository.dart';
import 'package:mspr_project/widgets/snackbar/snackbar.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
/*     TextButton(onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()));
            } */
    return Scaffold(
        appBar: AppBar(
          title: Text('Votre Profil'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                FractionallySizedBox(
                          widthFactor: 0.9,
                          child: RaisedButton.icon(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrdersPage()),
                    );
                            },
                            label: Text("Voir mes commandes",
                                style: TextStyle(color: Colors.white)),
                            icon: Icon(Icons.check_circle_outline,
                                color: Colors.white),
                          ),
                        ),
                
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
                    obscureText: false,
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
                    obscureText: false,
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
                    obscureText: false,
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
                    obscureText: false,
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
                      onPressed: () async {
                        bool response = await userRepository.editUser(
                            addressLine1Controller.text,
                            addressLine2Controller.text,
                            cityController.text,
                            phoneController.text,
                            zipCodeController.text);
                            if(response){
                                showSnackBar(context, 'Changements pris en compte', Colors.blue);
                          }else{
                            showSnackBar(context, 'Une erreur est survenue', Colors.yellow[900]);
                          }
                      },
                    )),
              ],
            )));
  }
  _getUserData() async {
    var rst = await userRepository.getUser();
    phoneController.text = rst.phoneNumber == null ?null : rst.phoneNumber;
    addressLine1Controller.text = rst.phoneNumber == null ?null : rst.addressLine1;
    addressLine2Controller.text = rst.phoneNumber == null ?null : rst.addressLine2;
    zipCodeController.text = rst.phoneNumber == null ?null : rst.zipCode;
  }
}
