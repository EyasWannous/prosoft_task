// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState({
    required this.products,
    required this.categories,
    required this.currentCategory,
    required this.status,
  });

  ProductState.initial()
      : this(
          products: [],
          categories: ['All'],
          currentCategory: 'All',
          status: ProductStatus.initial,
        );

  final List<Product> products;
  final List<String> categories;
  final String currentCategory;
  final ProductStatus status;

  @override
  List<Object> get props => [products, categories, currentCategory, status];

  ProductState copyWith({
    List<Product>? products,
    List<String>? categories,
    String? currentCategory,
    ProductStatus? status,
  }) {
    return ProductState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      currentCategory: currentCategory ?? this.currentCategory,
      status: status ?? this.status,
    );
  }
}
