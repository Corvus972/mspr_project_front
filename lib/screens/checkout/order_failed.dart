import 'package:flutter/material.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';


class OrderFailedPage extends StatefulWidget {
  static String routeName = "/order_failed";
  const OrderFailedPage({Key key}) : super(key: key);

  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderFailedPage> {
@override
void initState() {
   super.initState();
   if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
        SchedulerBinding.instance.addPostFrameCallback((_) => customRedirectAfterDelay());
   }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Erreur')),
        body: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                                "Il y a eu une erreur dans votre commande")),
                        Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.remove_circle_outline_rounded,
                            color: Colors.red,
                            size: 50,)),
                      ])),
        bottomSheet: BottomNav());
  }

  customRedirectAfterDelay(){
    Timer(Duration(seconds: 3), () {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
    });
  }
}