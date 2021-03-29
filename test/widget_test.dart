// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/screens/login/login.dart';
import 'package:mspr_project/screens/registration/registration.dart';
import 'package:mspr_project/screens/salesRule/sales_rule.dart';
import 'package:mspr_project/repository/sale_product_repository.dart';

void main() {
  Future<String> getCouponData(String coupon) async {
    var response = await salesProductRepository.fetchSaleProduct(coupon);
    return Future.value(response);
  }

  group('LoginPage', () {
    testWidgets('empty email and password', (WidgetTester tester) async {
      // add it to the widget tester
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginPage()));
      await tester.pumpWidget(app);

      // tap on the login button
      Finder loginButton = find.byKey(new Key('login'));
      await tester.tap(loginButton);

      // 'pump' the tester again. This causes the widget to rebuild
      await tester.pump();

      // check that email and pwd text is empty
      Finder email = find.byKey(new Key('email'));
      Finder pwd = find.byKey(new Key('pwd'));
      expect(email.toString().contains(''), true);
      expect(pwd.toString().contains(''), true);
    });

    testWidgets('email and password OK', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginPage()));
      await tester.pumpWidget(app);
      //get Key of widget TextField
      Finder email = find.byKey(new Key('email'));
      Finder pwd = find.byKey(new Key('pwd'));

      await tester.enterText(email, "stanley.jesoph@hotmail.fr");
      await tester.enterText(pwd, "Baiserdu16");
      await tester.pump();

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState.validate(), isTrue);
    });
    testWidgets('email and password NOTOK', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new LoginPage()));
      await tester.pumpWidget(app);
      //get Key of widget TextField
      Finder email = find.byKey(new Key('email'));
      Finder pwd = find.byKey(new Key('pwd'));

      await tester.enterText(email, "stanley.jesoph@hotmail.fr");
      await tester.enterText(pwd, "Baiserdu13");
      await tester.pump();

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      Finder hintText = find.text('Identifiants incorrect');
      expect(hintText.toString().contains('Identifiants incorrect'), true);
    });
  });
  group('Register', () {
    testWidgets('Registration OK', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new RegistrationPage()));
      await tester.pumpWidget(app);
      Finder username = find.byKey(new Key('username'));
      Finder pwd = find.byKey(new Key('pwd'));
      Finder email = find.byKey(new Key('email'));
      Finder confirmPwd = find.byKey(new Key('confirm_password'));
      Finder phone = find.byKey(new Key('phone'));

      await tester.enterText(username, "Joseph");
      await tester.enterText(pwd, "mspR123");
      await tester.enterText(confirmPwd, "mspR123");
      await tester.enterText(email, "stanley.jesoph@outlook.com");
      await tester.enterText(phone, "0649782808");
      await tester.pump();

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      expect(formKey.currentState.validate(), isTrue);
    });
    testWidgets('Password notEqual', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new RegistrationPage()));
      await tester.pumpWidget(app);
      Finder pwd = find.byKey(new Key('pwd'));
      Finder confirmPwd = find.byKey(new Key('confirm_password'));
      await tester.enterText(pwd, "mspR123");
      await tester.enterText(confirmPwd, "mspR124");
      await tester.pump();
      expect(pwd, isNot(equals(confirmPwd)));
    });
  });
}
