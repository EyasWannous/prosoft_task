part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class CategoriesSubscriptionRequested extends ProductEvent {
  const CategoriesSubscriptionRequested();
}

final class ProductSubscriptionRequested extends ProductEvent {
  const ProductSubscriptionRequested();
}

final class CategoryChanged extends ProductEvent {
  const CategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

final class ProductAdd extends ProductEvent {
  const ProductAdd(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

final class ProductDeleted extends ProductEvent {
  const ProductDeleted(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}
