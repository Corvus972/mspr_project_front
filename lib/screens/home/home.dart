import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/product_repository.dart';
import 'package:mspr_project/screens/product/details.dart';
import 'package:mspr_project/widgets/search/search.dart';

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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(data));
              },
              icon: Icon(Icons.search),
            )
          ],
          centerTitle: true,
          title: Text('Home Page'),
        ),
        /*   body: _buildProductsListPage(data), */
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            itemCount: data.length,
            itemBuilder: (context, index) => Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Image.asset("assets/images/bag_1.png"),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text(data[index].productName),
                  subtitle: Text(data[index].description),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.zoom_in),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(product: data[index]),
                          ),
                        );
                      },
                    ),
                    FlatButton(
                      child: Icon(Icons.add_shopping_cart),
                      onPressed: () {/* ... */},
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
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
