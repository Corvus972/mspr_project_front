import 'package:mspr_project/provider/api_provider.dart';
import 'package:mspr_project/models/product.dart';
import 'package:rxdart/rxdart.dart';

class ProductRepository {
  ApiProvider _provider = ApiProvider();

  final _productFetcher = PublishSubject<List<Product>>();

  Observable<List<Product>> get product => _productFetcher.stream;

  fetchProducts() async {
    List<Product> productResponse = await _provider.fetchProducts();
    print('result:' + productResponse.toString());
    _productFetcher.sink.add(productResponse);
  }

  dispose() {
    _productFetcher.close();
  }
}

final productRepository = ProductRepository();
