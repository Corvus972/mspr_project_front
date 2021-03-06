import 'package:mspr_project/models/product.dart';

/* @JsonSerializable()
@CustomDateTimeConverter() */
class Cart extends Product {
  int quantity;

  int get getQuantity => quantity;

  set setQuantity(int quantity) => this.quantity = quantity;

  Cart({
    this.quantity,
  });
}
