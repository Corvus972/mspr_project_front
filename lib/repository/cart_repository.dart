import 'dart:async';
import 'package:mspr_project/models/cart.dart';

class CartProvider {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final List<Cart> allItems = [];

  double totalSum = 0;

  int getIndexItem(item) {
    return allItems.indexWhere((element) => element.productId == item.sku);
  }

  void addToCart(item) {
    int index = getIndexItem(item);

    if (index < 0) {
      allItems.add(Cart(item.sku, 1, item.productPrice, item));
    } else {
      if (item.stock > allItems[index].quantity) {
        allItems[index].quantity++;
      }
    }
    print(totalByProduct(item));
    print(totalCart());

    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems.remove(item);
    totalCart();
    cartStreamController.sink.add(allItems);
  }

  double totalByProduct(item) {
    int index = getIndexItem(item);
    return allItems[index].quantity *
        double.parse(allItems[index].price.toString());
  }

  double totalCart() {
    print('in function');
    allItems.forEach((element) {
      totalSum += element.quantity * double.parse(element.price.toString());
    });
    print('in function:' + totalSum.toString());
    return totalSum;
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final cartRepository = CartProvider();
