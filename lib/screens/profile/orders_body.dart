import 'package:flutter/material.dart';
import 'package:mspr_project/models/order.dart';

class OrdersBody extends StatelessWidget {
  final List<Order> data;

  const OrdersBody(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        itemCount: data.length,
        itemBuilder: (context, index){
          if(index == 0){
              return Table(
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
              TableCell(child: Center(child: Text('Voir plus'))),
            ])]);
          }else {
        return Text("data");
      }
        }
      ),
    );
  }

}

