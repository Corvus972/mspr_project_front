import 'package:decimal/decimal.dart';



class ProductOrdered {
  int id;
  String productName;
  Decimal productPrice;
  String description;
  int stock;
  int quantity;
  DateTime createdAt;
  String sku;
  String image;

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getProductName => productName;

  set setProductName(String productName) => this.productName = productName;

  String get getDescription => description;

  set setDescription(String description) => this.description = description;

  int get getStock => stock;

  set setStock(int stock) => this.stock = stock;

  int get getQuantity => quantity;

  set setQuantity(int quantity) => this.quantity = quantity;

  String get getSku => sku;

  set setSku(String sku) => this.sku = sku;

  String get getImage => image;

  set setImage(String image) => this.image = image;

  ProductOrdered(
      {this.id,
      this.productName,
      this.productPrice,
      this.description,
      this.stock,
      this.quantity,
      this.createdAt,
      this.sku,
      this.image});

  factory ProductOrdered.fromJson(Map<String, dynamic> json) {
    return ProductOrdered(
      id: json["product"]['id'],
      productName: json["product"]['product_name'],
      productPrice: Decimal.parse(json["product"]['product_price']),
      description: json["product"]['description'],
      stock: json["product"]['quantity'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json["product"]['created_at']),
      sku: json["product"]['sku'],
      image: "",
    );
  }
}
