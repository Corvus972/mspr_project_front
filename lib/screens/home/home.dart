import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/repository/product_repository.dart';
import 'package:mspr_project/screens/home/body.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/widgets/search/search.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:badges/badges.dart';

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search(data));
                },
                icon: Icon(Icons.search),
              ),
              Text('Accueil'),
              StreamBuilder(
                  stream: cartRepository.getStream,
                  initialData: cartRepository.qtyTotal,
                  builder: (c, s) {
                    return Center(
                      child: Badge(
                        position: BadgePosition.topEnd(top: 2),
                        animationDuration: Duration(milliseconds: 300),
                        animationType: BadgeAnimationType.slide,
                        badgeContent: Text(
                          '${cartRepository.itemCount}',
                          style: TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout(),
                              ),
                            );
                          },
                          icon: Icon(Icons.shopping_bag_outlined),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
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
