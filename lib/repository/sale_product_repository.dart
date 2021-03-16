import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/models/sales_rule.dart';
import 'package:rxdart/rxdart.dart';

class SalesProductRepository {
  ApiProvider _provider = ApiProvider();

  final _salesProductFetcher = PublishSubject<String>();

  Observable<String> get salesproduct => _salesProductFetcher.stream;

  Future<String> fetchSaleProduct(idProduct) async {
    String salesProductResponse = await _provider.fetchSaleProduct(idProduct);
    return salesProductResponse;
  }

  dispose() {
    _salesProductFetcher.close();
  }
}

final salesProductRepository = SalesProductRepository();
