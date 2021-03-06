import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mspr_project/helper/custom_datetime.dart';

/* @JsonSerializable()
@CustomDateTimeConverter() */
class Product {
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

  set setStock(int quantity) => this.stock = stock;

  int get getQuantity => quantity;

  set setQuantity(int quantity) => this.quantity = quantity;

  String get getSku => sku;

  set setSku(String sku) => this.sku = sku;

  String get getImage => image;

  set setImage(String image) => this.image = image;

  Product(
      {this.id,
      this.productName,
      this.productPrice,
      this.description,
      this.stock,
      this.quantity = 0,
      this.createdAt,
      this.sku,
      this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      productPrice: Decimal.parse(json['product_price']),
      description: json['description'],
      stock: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      sku: json['sku'],
      image: json['image'],
    );
  }
}
