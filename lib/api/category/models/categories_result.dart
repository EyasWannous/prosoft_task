import 'package:json_annotation/json_annotation.dart';

part 'categories_result.g.dart';

@JsonSerializable()
class CategoriesResult {
  CategoriesResult({required this.categories});

  List<String> categories;

  factory CategoriesResult.fromJson(List<dynamic> json) =>
      _$CategoriesResultFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResultToJson(this);
}
