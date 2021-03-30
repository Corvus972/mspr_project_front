import 'package:decimal/decimal.dart';
import 'package:mspr_project/models/product.dart';

class Cart {
  String productId;
  int quantity;
  Decimal price;
  Product product;

  Cart(this.productId, this.quantity, this.price, this.product);

  String get getProductId => productId;

  set setProductId(String productId) => this.productId = productId;

  int get getQuantity => quantity;

  set setQuantity(int quantity) => this.quantity = quantity;

  Decimal get getPrice => price;

  set setPrice(Decimal price) => this.price = price;

  Product get getProduct => product;

  set setProduct(Product product) => this.product = product;

  double get totalByProduct => double.parse(price.toString()) * quantity;
}
