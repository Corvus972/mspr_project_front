import 'package:flutter/material.dart';
import 'package:mspr_project/repository/sale_product_repository.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:mspr_project/repository/sales_rule_repository.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:mspr_project/widgets/snackbar/snackbar.dart';

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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(qrCodeResult,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    String codeSanner = await BarcodeScanner.scan();
                    productCouponCode = await getCouponData(codeSanner);
                    setState(() {
                      qrCodeResult = productCouponCode;
                    }); //barcode scnner
                  },
                  child: Icon(Icons.qr_code_scanner_outlined),
                  backgroundColor: Colors.black,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
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
        bottomNavigationBar: BottomNav(),
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

  getCouponData(String coupon) async {
    var ruleProductData = await salesProductRepository.fetchSaleProduct(coupon);
    if (ruleProductData["status"] == 401) {
      showSnackBar(context, 'Aucun Promotion trouvé');
      return "Votre qr code ne correspond pas";
    } else {
      return ruleProductData["body"][0]["coupon_code"] +
          " associé à " +
          ruleProductData["body"][0]["name"];
    }
  }
}
