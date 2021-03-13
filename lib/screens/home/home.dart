import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/product_repository.dart';
import 'package:mspr_project/screens/home/body.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/widgets/header/header.dart';


class HomePage extends StatefulWidget {
  static String routeName = "/";
  @override
  _HomePageState createState() => _HomePageState();
/*   final List<String> list = List.generate(10, (index) => "Text $index");
 */
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    productRepository.fetchProducts();

    Scaffold _buildScreen(List<Product> data) {
      return Scaffold(
        appBar: AppBar(
            actions: <Widget>[],
            centerTitle: false,
            title: Header(
              data: data,
              title: 'Accueil',
            )),
        /*   body: _buildProductsListPage(data), */
        body: HomeBody(data),
        bottomSheet: BottomNav(),
      );
    }

    return StreamBuilder(
        stream: productRepository.product,
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return _buildScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
