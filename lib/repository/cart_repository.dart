import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mspr_project/models/cart.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/repository/product_repository.dart';

class CartProvider {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  List<Cart> allItems = [];

  double totalSum = 0.0;

  int get itemCount {
    return allItems.length;
  }

  int getIndexItem(item) {
    return allItems.indexWhere((element) => element.productId == item.sku);
  }

  void addToCart(Product item) {
    int index = getIndexItem(item);
    Cart carItem = Cart(item.sku, 1, item.productPrice, item);
    if (index < 0) {
      allItems.add(carItem);
    } else {
      if (item.stock > allItems[index].quantity) {
        allItems[index].quantity++;
      }
    }
    /* print(totalByProduct(item)); */
    totalCart();
    cartStreamController.sink.add(allItems);
    /* cartStreamController.sink.add(totalSum); */
  }

  void removeFromCart(Cart item) {
    allItems.remove(item);
    totalCart();
    cartStreamController.sink.add(allItems);
    /* cartStreamController.sink.add(totalSum); */
  }

  double totalCart() {
    print('in function');
    totalSum = 0;
    allItems.forEach((element) {
      totalSum += element.quantity * double.parse(element.price.toString());
    });
    print('in function:' + totalSum.toString());
    return totalSum;
  }

  void increase(Cart item) {
    int index = allItems.indexWhere((element) => element == item);
    int productStock = item.product.stock;
    if (allItems[index].quantity < productStock) {
      allItems[index].quantity++;
      totalCart();
      print('quantity ok');
    } else {
      print('not anymore quantity');
    }
  }

  void decrease(Cart item) {
    int index = allItems.indexWhere((element) => element == item);
    print(index);
    if (allItems[index].quantity > 0) {
      allItems[index].quantity--;
    }
    if (allItems[index].quantity == 0) {
      removeFromCart(item);
    }
    totalCart();
  }

  void clear() {
    allItems = [];
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree

  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final cartRepository = CartProvider();
