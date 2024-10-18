import 'package:json_annotation/json_annotation.dart';
import 'package:prosoft_task/api/product/models/product.dart';

part 'product_result.g.dart';

@JsonSerializable()
class ProductResult {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductResult({this.products, this.total, this.skip, this.limit});

  factory ProductResult.fromJson(Map<String, dynamic> json) =>
      _$ProductResultFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResultToJson(this);
}
