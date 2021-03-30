import 'dart:async';
import 'package:mspr_project/models/order.dart';
import 'package:mspr_project/models/product_ordered.dart';
import 'package:mspr_project/provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class OrderProvider {

  ApiProvider _provider = ApiProvider();

  final _orderFetcher = PublishSubject<List<Order>>();

  Stream<List<Order>> get order => _orderFetcher.stream;

  fetchOrders() async {
    List<Order> orderResponse = await _provider.fetchOrders();
    _orderFetcher.sink.add(orderResponse);
  }
  


  void dispose() {
    _orderFetcher.close(); // close our StreamController
  }
  double getTotalOrder(List<ProductOrdered> products){
    double total = 0;
    for (var item in products) {
      total += item.quantity * double.parse(item.productPrice.toString());
      
    }
    return total;

  }
}

final orderRepository = OrderProvider();
