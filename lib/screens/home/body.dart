import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/screens/product/details.dart';
import 'package:mspr_project/repository/cart_repository.dart';

class HomeBody extends StatelessWidget {
  final List<Product> data;

  const HomeBody(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: data.length,
        itemBuilder: (context, index) => Card(
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Image.network(
              data[index].image,
              fit: BoxFit.cover,
              height: 200,
              width: 350,
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text(
                data[index].productName,
                textAlign: TextAlign.end,
              ),
              subtitle:
                  Text(data[index].description, textAlign: TextAlign.start),
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
                widthFactor: 1, // means 100%, you can change this to 0.8 (80%)
                child: RaisedButton.icon(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
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
      ),
    );
  }
}
