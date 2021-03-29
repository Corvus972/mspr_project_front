import 'package:flutter/material.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/checkout/order_failed.dart';
import 'package:mspr_project/screens/checkout/order_success.dart';
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
  CheckoutPage.routeName: (context) => CheckoutPage(),
  ProfilePage.routeName: (context) => ProfilePage(),
  SalesRulePage.routeName: (context) => SalesRulePage(),
  OrderSuccessPage.routeName: (context) => OrderSuccessPage(),
  OrderFailedPage.routeName: (context) => OrderFailedPage(),
};
