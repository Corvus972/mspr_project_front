/* import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/product_repository.dart';
import 'package:mspr_project/screens/product/details.dart';
import 'package:mspr_project/repository/cart_repository.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  
  @override
  Widget build(BuildContext context) {
    productRepository.fetchProducts();
return Scaffold _buildScreen(List<Product> data) {
    ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      itemCount: data.length,
      itemBuilder: (context, index) => Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image.network(data[index].image, fit: BoxFit.cover, height: 100.0),
          ListTile(
            leading: Icon(Icons.check),
            title: Text(data[index].productName),
            subtitle: Text(data[index].description),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("plus de détails"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(product: data[index]),
                    ),
                  );
                },
              ),
              Text(
                '${data[index].productPrice.toString()} €',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Container(
            child: FractionallySizedBox(
              widthFactor: 0.7, // means 100%, you can change this to 0.8 (80%)
              child: RaisedButton.icon(
                color: Colors.green,
                onPressed: () {
                  cartRepository.addToCart(data[index]);
                },
                label: Text("Ajouter au panier",
                    style: TextStyle(color: Colors.white)),
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  };
  }
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
  } */