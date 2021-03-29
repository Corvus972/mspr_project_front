import 'dart:async';
import 'package:mspr_project/models/cart.dart';
import 'package:mspr_project/models/product.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/repository/sales_rule_repository.dart';

class CartProvider {

  ApiProvider _provider = ApiProvider();
  
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  List<Cart> allItems = [];

  double totalSum = 0.0;

  int qtyTotal = 0;

  int get itemCount {
    return qtyTotal;
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
    totalSum = 0;
    qtyTotal = 0;
    allItems.forEach((element) {
      qtyTotal += element.quantity;
      totalSum += element.quantity * double.parse(element.price.toString());
    });
    return totalSum;
  }

  bool increase(Cart item) {
    int index = allItems.indexWhere((element) => element == item);
    int productStock = item.product.stock;
    if (allItems[index].quantity < productStock) {
      allItems[index].quantity++;
      cartStreamController.sink.add(allItems);
      totalCart();
      return true;
    }
    return false;
  }

  void decrease(Cart item) {
    int index = allItems.indexWhere((element) => element == item);
    if (allItems[index].quantity > 0) {
      allItems[index].quantity--;
      cartStreamController.sink.add(allItems);
    }
    if (allItems[index].quantity == 0) {
      removeFromCart(item);
    }
    totalCart();
  }

  Future<bool> applyDiscount(String couponCode) {
    bool response = false;
    var repo = salesRuleRepository;
    repo.fetchSalesRule();
    repo.salesrule.listen((event) {
      SalesRule salesR = event.firstWhere(
          (element) => element.couponCode == couponCode, orElse: () {
        return null;
      });
      print("object: " + salesR.couponCode.toString());

      if (salesR != null) {
        List<Product> products = salesR.productAssociated;
        for (var item in products) {
          Cart prodAss = allItems.firstWhere(
              (element) => element.product.sku == item.sku, orElse: () {
            return null;
          });
          if (prodAss != null) {
            prodAss.price = item.productPrice;
          }
        }
        cartStreamController.sink.add(allItems);
        response = true;
        totalCart();
      }
    });
    return Future.delayed(
      Duration(seconds: 1),
      () => response,
    );
    /* return Future.value(false); */
  }
  Future<bool> sendOrder() async {
    Map<String, List> items = {"items":[]};
    allItems.forEach((element) => {
      items["items"].add({
            "product": element.product.id,
            "quantity": element.quantity
        
        })
     });
     /* print(items); */
    bool result = await _provider.sendOrder(items);
    if(result){
      allItems = [];
      cartStreamController.sink.add(allItems);
      totalCart();
    }
    return result;
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
