import 'package:mspr_project/models/product.dart';
import 'package:decimal/decimal.dart';
import 'package:mspr_project/helper/custom_datetime.dart';
import 'package:intl/intl.dart';

class SalesRule {
  int id;
  String name;
  String description;
  String fromData;
  String toData;
  String couponCode;
  int discountAmount;
  Product productAssociated;

  int get getId => id;

  set setId(int id) => this.id = id;

  String get getName => name;

  set setName(String name) => this.name = name;

  String get getDescription => description;

  set setDescription(String description) => this.description = description;

  String get getCouponCode => couponCode;

  set setCouponCode(String couponCode) => this.couponCode = couponCode;

  int get getDiscountAmount => discountAmount;

  set setDiscountAmount(int discountAmount) =>
      this.discountAmount = discountAmount;

  SalesRule(
      {this.id,
      this.name,
      this.description,
      this.fromData,
      this.toData,
      this.couponCode,
      this.discountAmount,
      this.productAssociated});
  factory SalesRule.fromJson(Map<String, dynamic> json) {
    var fromDataParse =
        new DateFormat("dd-MM-yyyy").format(DateTime.parse(json['from_data']));
    var toDataParse =
        new DateFormat("dd-MM-yyyy").format(DateTime.parse(json['to_data']));
    return SalesRule(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        fromData: fromDataParse,
        toData: toDataParse,
        couponCode: json['coupon_code'],
        discountAmount: json['discount_amount'],
        productAssociated: Product.fromJson(json['product_associated'][0]));
  }
}
