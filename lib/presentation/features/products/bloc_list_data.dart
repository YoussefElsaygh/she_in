import 'package:she_in/data/model/category.dart';
import 'package:she_in/data/model/filter_rules.dart';
import 'package:she_in/data/model/product.dart';

class ProductListData {
  final List<Product> products;
  final ProductCategory category;
  final FilterRules filterRules;

  ProductListData(this.products, this.category, this.filterRules);

  ProductListData copyWith(List<Product> updatedProducts) {
    return ProductListData(updatedProducts, category, filterRules);
  }
}
