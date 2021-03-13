import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class SalesRuleRepository {
  ApiProvider _provider = ApiProvider();

  final _salesRuleFetcher = PublishSubject<List<SalesRule>>();

  Stream<List<SalesRule>> get salesrule => _salesRuleFetcher.stream;

  fetchSpecificSalesRule(String event) async {
    _salesRuleFetcher.listen((event) {
      /* for (String myString in event) {
        print(myString);
      } */
    });
  }

  fetchSalesRule() async {
    List<SalesRule> salesRuleResponse = await _provider.fetchSalesRule();
    _salesRuleFetcher.sink.add(salesRuleResponse);
  }

  dispose() {
    _salesRuleFetcher.close();
  }
}

final salesRuleRepository = SalesRuleRepository();
