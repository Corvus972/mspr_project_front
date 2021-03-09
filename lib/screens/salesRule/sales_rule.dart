import 'package:flutter/material.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/repository/sales_rule_repository.dart';
import 'package:mspr_project/widgets/search/search.dart';

class SalesRulePage extends StatefulWidget {
  static String routeName = "/salesrule";
  @override
  _SalesRuleState createState() => _SalesRuleState();
}

class _SalesRuleState extends State<SalesRulePage> {
  @override
  Widget build(BuildContext context) {
    salesRuleRepository.fetchSalesRule();
    Scaffold _buildScreen(List<SalesRule> data) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Promotion en cours')),
        body: Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            itemCount: data.length,
            itemBuilder: (context, index) => Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: Icon(Icons.blur_on_rounded),
                  title: Text(data[index].name),
                  subtitle: Text(data[index].description),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                        'Valide du ${data[index].fromData} jusqu\'au ${data[index].toData}',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ]),
            ),
          ),
        ),
      );
    }

    return StreamBuilder(
        stream: salesRuleRepository.salesrule,
        builder: (context, AsyncSnapshot<List<SalesRule>> snapshot) {
          if (snapshot.hasData) {
            return _buildScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
