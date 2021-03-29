import 'package:flutter/material.dart';
import 'package:mspr_project/screens/profile/orders.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = "/profile";
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profil')),
        body: Column(
          children: [
            Text("Profile page"),
            TextButton(onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdersPage()));
            }, child: Text("Voir mes commandes"))
          ],
        ),
        bottomSheet: BottomNav());
  }
}
