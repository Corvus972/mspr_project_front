import 'package:flutter/material.dart';
import 'package:mspr_project/models/order.dart';
import 'package:mspr_project/repository/order_repository.dart';

class OrdersBody extends StatelessWidget {
  final List<Order> data;

  const OrdersBody(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: ListView(
                children: <Widget>[
                  Table(
                      defaultColumnWidth:FixedColumnWidth(MediaQuery.of(context).size.width / 3),
                      border: TableBorder.all(
                          color: Colors.black26, width: 1, style: BorderStyle.none),
                      children: [
                        TableRow(children: [
                          TableCell(child: Center(child: Text('Date'))),
                          TableCell(
                            child: Center(child: Text('Nbre Produits')),
                          ),
                          TableCell(child: Center(child: Text('Total'))),
                        ])]
              ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        itemCount: data.length,
                        itemBuilder: (context, index){
                        return Table(
                      defaultColumnWidth:FixedColumnWidth(MediaQuery.of(context).size.width / 4),
                      border: TableBorder.all(
                          color: Colors.black26, width: 1, style: BorderStyle.none),
                      children: [
                        TableRow(children: [
                          TableCell(child: Center(child: TextButton(onPressed: (){}, child: Text('${data[index].date}')))),
                          TableCell(
                            child: Center(child: TextButton(onPressed: (){}, child: Text('${data[index].items.length}')))
                          ),
                          TableCell(child: Center(child: TextButton(onPressed: (){}, child: Text("${orderRepository.getTotalOrder(data[index].items)} €")))),
                        ])]
              );
                        }
                      ),
                    )
                ]
              ),
            )
          );
  }
}
