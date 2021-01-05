
import 'package:she_in/data/repositories/abstract/category_repository.dart';
import 'package:she_in/data/model/category.dart';
import 'package:she_in/data/error/exceptions.dart';
import 'package:she_in/data/local/local_category_repository.dart';
import 'package:she_in/data/network/network_status.dart';
import 'package:she_in/data/woocommerce/repositories/category_remote_repository.dart';
import 'package:she_in/locator.dart';

//Uses remote or local data depending on NetworkStatus
class CategoryRepositoryImpl extends CategoryRepository {

  @override
  Future<List<ProductCategory>> getCategories({int parentCategoryId = 0}) async {
    try
    {
      NetworkStatus networkStatus = sl();
      CategoryRepository categoryRepository;
      if ( networkStatus.isConnected != null ) {
        categoryRepository = RemoteCategoryRepository(woocommerce: sl());
      } else {
        categoryRepository = LocalCategoryRepository();
      }

      return await categoryRepository.getCategories(parentCategoryId: parentCategoryId);
    } on HttpRequestException {
      throw RemoteServerException();
    }
  }

  @override
  Future<ProductCategory> getCategoryDetails(int categoryId) async {
    // TODO: implement getCategoryDetails
    List<ProductCategory> categories = await getCategories();
    return categories.isNotEmpty ? categories[0] : null;
  }
}
