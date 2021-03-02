import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mspr_project/config/routes.dart';
import 'package:mspr_project/config/theme.dart';
import 'package:mspr_project/screens/home/home.dart';

void main() async {
  runApp(FlutterCommerceApp());
}

class FlutterCommerceApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlutterCommerceConfig.of(context),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: '/',
      routes: routes,
    );
  }
}

/* class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

class FlutterCommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "E-commerce",
        theme: FlutterCommerceConfig.of(context),
        routes: _registerRoutes());
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      FlutterCommerceRoutes.home: (context) => HomePage(),
    };
  }
} */
