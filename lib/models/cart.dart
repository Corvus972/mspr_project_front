import 'package:decimal/decimal.dart';
import 'package:mspr_project/models/product.dart';

/* @JsonSerializable()
@CustomDateTimeConverter() */
class Cart {
  String productId;
  int quantity;
  Decimal price;
  Product product;

  String get getProductId => productId;

  set setProductId(String productId) => this.productId = productId;

  int get getQuantity => quantity;

  set setQuantity(int quantity) => this.quantity = quantity;

  Decimal get getPrice => price;

  set setPrice(Decimal price) => this.price = price;

  Product get getProduct => product;

  set setProduct(Product product) => this.product = product;

  Cart(this.productId, this.quantity, this.price, this.product);
}
