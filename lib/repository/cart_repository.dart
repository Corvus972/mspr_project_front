import 'dart:async';
import 'package:mspr_project/models/cart.dart';

class CartProvider {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final List<Cart> allItems = [];

  void addToCart(item) {
    final index =
        allItems.indexWhere((element) => element.productId == item.sku);
    if (index < 0) {
      allItems.add(Cart(item.sku, 1, item.productPrice, item));
    } else {
      if (item.stock > allItems[index].quantity) {
        allItems[index].quantity++;
      }
    }

    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems.remove(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final cartRepository = CartProvider();
