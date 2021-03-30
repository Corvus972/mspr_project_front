import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspr_project/screens/registration/registration.dart';

void registration() {
  group('Register', () {
    testWidgets('Registration OK', (WidgetTester tester) async {
      var app = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new RegistrationPage()));
      await tester.pumpWidget(app);
      Finder pwd = find.byKey(new Key('pwd'));
      Finder email = find.byKey(new Key('email'));
      Finder confirmPwd = find.byKey(new Key('confirm_password'));
      Finder phone = find.byKey(new Key('phone'));

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
  });
}
