import 'package:flutter/material.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Text("Registration page"),
        bottomSheet: BottomNav());
  }
}
