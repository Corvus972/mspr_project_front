import 'package:flutter/material.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/product/details.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/screens/profile/profile.dart';
import 'package:mspr_project/screens/salesRule/sales_rule.dart';

/* class FlutterCommerceRoutes {
  static const home = "/";
  static const details = "details";
  static const cart = "cart";
} */

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  Details.routeName: (context) => Details(product: null),
  Checkout.routeName: (context) => Checkout(),
  ProfilePage.routeName: (context) => ProfilePage(),
  SalesRulePage.routeName: (context) => SalesRulePage(),
};
