import 'dart:async';

class CartProvider {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final Map allItems = {'cart_items': []};

  void addToCart(item) {
    allItems['cart_items'].add(item);
    cartStreamController.sink.add(allItems);
    /*   print(allItems['cart'].where((i) => i.id.contains(item.id))); */
    print(allItems['cart_items']);
  }

  void removeFromCart(item) {
    allItems['cart_items'].remove(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final cartRepository = CartProvider();
