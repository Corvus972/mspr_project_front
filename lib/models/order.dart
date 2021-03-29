import 'package:intl/intl.dart';
import 'package:mspr_project/models/product_ordered.dart';


class Order {
  int id;
  String status;
  String date;
  List<ProductOrdered> items;

 int get getId => this.id;

 set setId(int id) => this.id = id;

  get getStatus => this.status;

 set setStatus( status) => this.status = status;

  get getDate => this.date;

 set setDate( date) => this.date = date;

 Order({
        this.id,
        this.status,
        this.date,
        this.items
      });

  factory Order.fromJson(Map<String, dynamic> json) {

    //product associated
    var list = json['items']as List;
    List<ProductOrdered> listProducts = list.map((i) => ProductOrdered.fromJson(i)).toList();
    
    var dataParse =
        new DateFormat("dd-MM-yyyy").format(DateTime.parse(json['date']));
        
    return Order(
      id: json['id'],
      status: json['status'],
      date:dataParse,
      items:listProducts
    );
  }


  
}
