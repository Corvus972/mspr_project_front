import 'package:flutter/material.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';


class OrderSuccessPage extends StatefulWidget {
  static String routeName = "/order_success";
  const OrderSuccessPage({Key key}) : super(key: key);

  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
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
        appBar: AppBar(title: Text('Succès')),
        body: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                                "Votre commande a bien été passée ")),
                        Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.check_circle_rounded,
                            color: Colors.green,
                            size: 50,)),
                      ])),
        bottomSheet: BottomNav());
  }

  customRedirectAfterDelay(){
    Timer(Duration(seconds: 3), () {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
                      );
    });
  }
}