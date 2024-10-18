import 'package:prosoft_task/api/category/models/categories_result.dart';

abstract class ICategoryRepository {
  const ICategoryRepository();

  Future<CategoriesResult?> getCategories();
}
