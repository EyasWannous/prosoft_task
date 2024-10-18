import 'package:prosoft_task/api/product/models/models.dart';

abstract class IProductRepository {
  const IProductRepository();

  Future<ProductResult?> getAllProducts({int skip = 0, int limit = 10});

  Future<ProductResult?> getProductsByCategory(String category);

  Future<Product?> addProduct(Product product, String token);

  Future<Product?> updateProduct(Product product, String token);

  Future<bool> deleteProduct(int id, String token);
}
