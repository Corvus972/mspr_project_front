import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/provider/auth.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/widgets/search/search.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/widgets/snackbar/snackbar.dart';

class Header extends StatelessWidget {
  final List<Product> data;
  final String title;
  const Header({Key key, this.data, @required this.title})
      : super(key: key);
  Future<String> _checkIfLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return Future.value(token);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
        Widget>[
      IconButton(
        onPressed: () {
          showSearch(context: context, delegate: Search(data));
        },
        icon: Icon(Icons.search),
      ),
      Text(title),
      StreamBuilder(
          stream: cartRepository.getStream,
          initialData: cartRepository.qtyTotal,
          builder: (c, s) {
            return Center(
              child: Badge(
                position: BadgePosition.topEnd(top: 5),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  '${cartRepository.itemCount}',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              ),
            );
          }),
      Container(
        child: FutureBuilder<String>(
            future: _checkIfLogin(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove("token");
                      authService.isLogged = false;
                      showSnackBar(context, 'Vous êtes déconnecté');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.logout));
              } else {
                return Text("");
              }
            }),
        width: 30.0,
      ),
    ]);
  }
}
