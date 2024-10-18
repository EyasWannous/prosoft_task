import 'dart:convert';

import 'package:prosoft_task/api/product/i_product_repository.dart';
import 'package:prosoft_task/api/product/models/product.dart';
import 'package:prosoft_task/api/product/models/product_result.dart';
import 'package:prosoft_task/api/product/product_client.dart';
import 'package:prosoft_task/api/storage.dart';

class ProductRepository extends IProductRepository {
  ProductRepository({
    required this.client,
    required this.storage,
  });

  final ProductClient client;
  final Storage storage;
  static const String key = 'prodcuts?';

  @override
  Future<ProductResult?> getAllProducts({int skip = 0, int limit = 10}) async {
    final result = await client.getAllProducts(skip: skip, limit: limit);
    if (result == null) {
      if (storage.contains('${key}limit=$limit&skip=$skip')) {
        final savedTasks = storage.getValue('${key}limit=$limit&skip=$skip');

        if (savedTasks == null) return null;

        final product = ProductResult.fromJson(
          jsonDecode(savedTasks) as Map<String, dynamic>,
        );

        return product;
      }
      return null;
    }

    await storage.setValue('${key}limit=$limit&skip=$skip', result);

    final product = ProductResult.fromJson(
      jsonDecode(result) as Map<String, dynamic>,
    );

    return product;
  }

  @override
  Future<ProductResult?> getProductsByCategory(String category) async {
    final result = await client.getProductsByCategory(category);
    if (result == null) {
      if (storage.contains('$key/$category')) {
        final savedTasks = storage.getValue('$key/$category');

        if (savedTasks == null) return null;

        final product = ProductResult.fromJson(
          jsonDecode(savedTasks) as Map<String, dynamic>,
        );

        return product;
      }
      return null;
    }

    await storage.setValue('$key/$category', result);

    final product = ProductResult.fromJson(
      jsonDecode(result) as Map<String, dynamic>,
    );

    return product;
  }

  @override
  Future<Product?> addProduct(Product product, String token) async {
    final result = await client.addProduct(product, token);
    if (result == null) {
      return product;
    }

    await storage.setValue('$key${product.id.toString()}', jsonEncode(result));
    storage.removeByPrefix(key);

    return product;
  }

  @override
  Future<bool> deleteProduct(int id, String token) async {
    final result = await client.deleteTask(id, storage.getValue('token')!);
    if (!result) {
      return false;
    }

    await storage.remove('$key${id.toString()}');
    storage.removeByPrefix(key);

    return true;
  }

  @override
  Future<Product?> updateProduct(Product product, String token) async {
    final result =
        await client.updateProduct(product, storage.getValue('token')!);
    if (result == null) {
      if (storage.contains(product.id.toString())) {
        final savedTask = storage.getValue('$key${product.id.toString()}');
        if (savedTask == null) {
          return product;
        }

        return Product.fromJson(jsonDecode(savedTask) as Map<String, dynamic>);
      }
      return product;
    }

    await storage.setValue('$key${product.id.toString()}', result.toString());
    storage.removeByPrefix(key);

    return result;
  }
}
