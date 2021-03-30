import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr_project/screens/login/login.dart';

void login() {
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

      await tester.enterText(email, "stanley.jesoph@admin.com");
      await tester.enterText(pwd, "mspr16");
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
      await tester.enterText(pwd, "mspr34");
      await tester.pump();

      Finder formWidgetFinder = find.byType(Form);
      Form formWidget = tester.widget(formWidgetFinder) as Form;
      GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;
      Finder hintText = find.text('Identifiants incorrect');
      expect(hintText.toString().contains('Identifiants incorrect'), true);
    });
  });
}
