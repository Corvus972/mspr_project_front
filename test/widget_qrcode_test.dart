import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/screens/salesRule/sales_rule.dart';
import 'package:mspr_project/repository/sale_product_repository.dart';

void qrCode() {
  group('Liste promotion', () {
    testWidgets('test promotion liste', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new SalesRulePage()));
      //not working
      //await tester.pumpWidget(app);
    });
  });
}
