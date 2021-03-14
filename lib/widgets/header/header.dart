import 'package:flutter/material.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/widgets/search/search.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:badges/badges.dart';

class Header extends StatelessWidget {
  final List<Product> data;
  final String title;
  const Header({Key key, @required this.data, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: Search(data));
          },
          icon: Icon(Icons.search),
        ),
        Text(title),
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
    );
  }
}
