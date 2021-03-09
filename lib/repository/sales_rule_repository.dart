import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:rxdart/rxdart.dart';

class SalesRuleRepository {
  ApiProvider _provider = ApiProvider();

  final _salesRuleFetcher = PublishSubject<List<SalesRule>>();

  Observable<List<SalesRule>> get salesrule => _salesRuleFetcher.stream;

  fetchSalesRule() async {
    List<SalesRule> salesRuleResponse = await _provider.fetchSalesRule();
    _salesRuleFetcher.sink.add(salesRuleResponse);
  }

  dispose() {
    _salesRuleFetcher.close();
  }
}

final salesRuleRepository = SalesRuleRepository();
