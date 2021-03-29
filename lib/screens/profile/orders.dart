import 'package:flutter/material.dart';
import 'package:mspr_project/models/order.dart';
import 'package:mspr_project/repository/order_repository.dart';
import 'package:mspr_project/screens/profile/orders_body.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';


class OrdersPage extends StatelessWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    orderRepository.fetchOrders();

    Scaffold _buildScreen(List<Order> data) {
      return Scaffold(
        appBar: AppBar(
            actions: <Widget>[],
            centerTitle: false,
            title: Text('Commandes passées')),
        body: OrdersBody(data),
        bottomNavigationBar: BottomNav(),
      );
    }



        return StreamBuilder(
        stream: orderRepository.order,
        builder: (context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            return _buildScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

   