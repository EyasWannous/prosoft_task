import 'dart:convert';

import 'package:prosoft_task/api/category/category_client.dart';
import 'package:prosoft_task/api/category/i_category_repository.dart';
import 'package:prosoft_task/api/category/models/categories_result.dart';
import 'package:prosoft_task/api/storage.dart';

class CategoryRepository extends ICategoryRepository {
  CategoryRepository({
    required this.client,
    required this.storage,
  });

  final CategoryClient client;
  final Storage storage;
  static const String key = 'categories?';

  @override
  Future<CategoriesResult?> getCategories() async {
    final result = await client.getCategories();
    if (result == null) {
      if (storage.contains(key)) {
        final savedTasks = storage.getValue(key);

        if (savedTasks == null) return null;

        final categories = CategoriesResult.fromJson(
          jsonDecode(savedTasks) as List<dynamic>,
        );

        return categories;
      }
      return null;
    }

    await storage.setValue(key, result);

    final categories = CategoriesResult.fromJson(
      jsonDecode(result) as List<dynamic>,
    );

    return categories;
  }
}
