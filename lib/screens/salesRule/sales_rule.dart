import 'package:flutter/material.dart';
import 'package:mspr_project/repository/sale_product_repository.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/repository/sales_rule_repository.dart';
import 'package:barcode_scan/barcode_scan.dart';

class SalesRulePage extends StatefulWidget {
  static String routeName = "/salesrule";
  @override
  _SalesRuleState createState() => _SalesRuleState();
}

class _SalesRuleState extends State<SalesRulePage> {
  String qrCodeResult = "Scannez un Qr Code";
  String productCouponCode;
  @override
  Widget build(BuildContext context) {
    salesRuleRepository.fetchSalesRule();
    Scaffold _buildScreen(List<SalesRule> data) {
      return Scaffold(
        extendBody: true,
        appBar: AppBar(centerTitle: true, title: Text('Promotion en cours')),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(qrCodeResult,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 110.0),
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 570.0),
          child: FloatingActionButton(
            onPressed: () async {
              String codeSanner = await BarcodeScanner.scan();
              productCouponCode = "Votre code promotionnelle : " +
                  await getCouponData(codeSanner);
              setState(() {
                if (qrCodeResult != null) {
                  qrCodeResult = productCouponCode;
                } else {
                  qrCodeResult = "Votre qr code ne correspond pas";
                }
              }); //barcode scnner
            },
            child: Icon(Icons.qr_code_scanner_outlined),
            backgroundColor: Colors.black,
          ),
        ),
        bottomSheet: BottomNav(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Future<String> getCouponData(String coupon) async {
    var response = await salesProductRepository.fetchSaleProduct(coupon);
    return Future.value(response);
  }
}
