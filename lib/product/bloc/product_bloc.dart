import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prosoft_task/api/category/i_category_repository.dart';
import 'package:prosoft_task/api/category/models/categories_result.dart';
import 'package:prosoft_task/api/product/i_product_repository.dart';
import 'package:prosoft_task/api/product/models/models.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required IProductRepository productRepository,
    required ICategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        _productRepository = productRepository,
        super(ProductState.initial()) {
    on<CategoriesSubscriptionRequested>(_onCategoriesSubscriptionRequested);
    on<ProductSubscriptionRequested>(_onProductSubscriptionRequested);
    on<ProductAdd>(_onProductAdd);
    on<ProductDeleted>(_onProductDeleted);

    on<CategoryChanged>(_categoryChanged);
  }

  final ICategoryRepository _categoryRepository;
  final IProductRepository _productRepository;
  final List<Product> products = [];
  final List<String> categroies = [];
  final int limit = 10;
  int skip = 0;

  Future<void> _onProductSubscriptionRequested(
    ProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    ProductResult? result = await _productRepository.getAllProducts(
      skip: skip,
      limit: limit,
    );
    if (skip == 0) {
      products.clear();

      if (result?.products == null || result!.products!.isEmpty) {
        emit(state.copyWith(
          status: ProductStatus.success,
          categories: categroies,
          products: products,
        ));

        return;
      }

      products.insertAll(0, result.products!);

      emit(state.copyWith(
        status: ProductStatus.success,
        categories: categroies,
        products: products,
      ));

      return;
    }

    if (result?.products != null && result!.products!.isNotEmpty) {
      products.insertAll(0, result.products!);
    }

    emit(state.copyWith(
      status: ProductStatus.success,
      categories: categroies,
      products: products,
    ));
  }

  FutureOr<void> _onProductAdd(
    ProductAdd event,
    Emitter<ProductState> emit,
  ) {}

  FutureOr<void> _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductState> emit,
  ) {}

  Future<void> _onCategoriesSubscriptionRequested(
    CategoriesSubscriptionRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    try {
      CategoriesResult? result = await _categoryRepository.getCategories();
      // print(result);
      if (result == null) {
        emit(state.copyWith(status: ProductStatus.failure));
        add(const ProductSubscriptionRequested());
        return;
      }

      categroies.add('All');
      categroies.addAll(result.categories);

      // emit(state.copyWith(
      //   status: ProductStatus.success,
      //   categories: categroies,
      // ));

      add(const ProductSubscriptionRequested());
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.failure));
      add(const ProductSubscriptionRequested());
    }
  }

  Future<void> onRefresh() async {
    skip += limit;
    add(const ProductSubscriptionRequested());
  }

  Future<void> _categoryChanged(
    CategoryChanged event,
    Emitter<ProductState> emit,
  ) async {
    if (event.category == 'All') {
      add(const ProductSubscriptionRequested());
      return;
    }

    emit(state.copyWith(status: ProductStatus.loading));

    ProductResult? result =
        await _productRepository.getProductsByCategory(event.category);
    if (result == null) {
      return;
    }
    products.clear();

    if (result.products != null && result.products!.isNotEmpty) {
      products.addAll(result.products!);
    }

    emit(state.copyWith(
      status: ProductStatus.success,
      products: products,
    ));
  }
}
