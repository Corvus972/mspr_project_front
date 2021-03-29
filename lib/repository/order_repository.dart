import 'dart:async';
import 'package:mspr_project/models/cart.dart';
import 'package:mspr_project/models/order.dart';
import 'package:mspr_project/provider/api_provider.dart';
import 'package:rxdart/rxdart.dart';

class OrderProvider {

  ApiProvider _provider = ApiProvider();

  final _orderFetcher = PublishSubject<List<Order>>();

  Stream<List<Order>> get order => _orderFetcher.stream;

  fetchOrders() async {
    List<Order> orderResponse = await _provider.fetchOrders();
    print('result:' + orderResponse.toString());
    _orderFetcher.sink.add(orderResponse);
  }


  void dispose() {
    _orderFetcher.close(); // close our StreamController
  }
}

final orderRepository = OrderProvider();
