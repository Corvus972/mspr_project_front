import 'package:flutter/material.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/screens/profile/profile.dart';
import 'package:mspr_project/screens/salesRule/sales_rule.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> itemsList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      label: 'Promotions',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Login'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped, // new
      currentIndex: _currentIndex, // new
      items: itemsList,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (itemsList[index].label) {
      case "Promotions":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalesRulePage(),
            ),
          );
        }
        break;

      case "Profile":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        }
        break;

      case "Login":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
        break;

      default:
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
        break;
    }
  }
}
