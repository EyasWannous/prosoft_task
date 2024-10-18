import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prosoft_task/api/product/models/models.dart';

class ProductClient {
  ProductClient({
    http.Client? httpClient,
    this.baseUrl = 'https://dummyjson.com/products',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<String?> getAllProducts({int skip = 0, int limit = 10}) async {
    try {
      final queryParameters = 'limit=$limit&skip=$skip';

      final getProductsReqeuest = Uri.parse('$baseUrl?$queryParameters');

      final response = await httpClient.get(getProductsReqeuest);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getProductsByCategory(String category) async {
    try {
      final getProductsReqeuest = Uri.parse('$baseUrl/category/$category');

      final response = await httpClient.get(getProductsReqeuest);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Product?> addProduct(Product product, String token) async {
    try {
      final productRequest = Uri.parse('$baseUrl/add');

      final response = await httpClient.post(
        productRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(product),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Product?> updateProduct(Product product, String token) async {
    try {
      final productRequest = Uri.parse('$baseUrl/${product.id}');

      final response = await httpClient.put(
        productRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(product),
      );

      if (response.statusCode == 200) {
        return product;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(int id, String token) async {
    try {
      final productRequest = Uri.parse('$baseUrl/$id');

      final response = await httpClient.delete(
        productRequest,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
