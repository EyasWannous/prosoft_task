import 'package:http/http.dart' as http;

class CategoryClient {
  CategoryClient({
    http.Client? httpClient,
    this.baseUrl = 'https://dummyjson.com/products/categories',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<String?> getCategories() async {
    try {
      final getProductsReqeuest = Uri.parse(baseUrl);

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
}
