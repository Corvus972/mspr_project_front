import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/product/colors.dart';
import 'package:badges/badges.dart';

class Details extends StatefulWidget {
  static String routeName = "/details";
  final Product product;

  Details({Key key, @required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.pink];
  List<String> imagePath = [
    "assets/images/shoe_blue.png",
    "assets/images/shoe_green.png",
    "assets/images/shoe_yellow.png",
    "assets/images/shoe_pink.png"
  ];
  var selectedColor = Colors.blue;
  var isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          header(),
          bodyDetails(),
          Expanded(child: section()),
          bottomButton()
        ],
      ),
    ));
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_backspace_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Column(
            children: [
              Text("Categorie",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
              Text(widget.product.productName,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
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
                            builder: (context) => CheckoutPage(),
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
    );
  }

  Widget bodyDetails() {
    return Container(
      child: Stack(
        children: [
          Image.network(widget.product.image, fit: BoxFit.cover, height: 300.0),
          /* Image.asset(imagePath[colors.indexOf(selectedColor)]), */
          Positioned(
              bottom: 10,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
                child: Image.asset(
                  isFavourite
                      ? "assets/images/heart_icon.png"
                      : "assets/images/heart_icon_disabled.png",
                  height: 34,
                  width: 34,
                ),
              ))
        ],
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.product.description,
            textAlign: TextAlign.justify,
            style:
                TextStyle(color: AppColor.bodyColor, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 20),
          property()
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Couleur",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                    4,
                    (index) => GestureDetector(
                          onTap: () {
                            print("index $index clicked");
                            setState(() {
                              selectedColor = colors[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 10),
                            height: 34,
                            width: 34,
                            child: selectedColor == colors[index]
                                ? Image.asset("assets/images/checker.png")
                                : SizedBox(),
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(17)),
                          ),
                        )),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Prix",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: AppColor.bodyColor.withOpacity(0.10),
                  child: Text(
                    '${widget.product.productPrice.toString()} €',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
      /* Row(
         Text('${widget.product.productPrice.toString()} €',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28)
        )
       ) */
    );
  }

  Widget bottomButton() {
    return Container(
      child: Container(
        child: FractionallySizedBox(
          widthFactor: 0.9, // means 100%, you can change this to 0.8 (80%)
          child: RaisedButton.icon(
            color: Colors.black,
            onPressed: () {
              cartRepository.addToCart(widget.product);
            },
            label: Text("Ajouter au panier",
                style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.add_shopping_cart, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
