import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/product/bloc/product_bloc.dart';
import 'package:prosoft_task/product/view/view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.status != ProductStatus.success &&
          current.status != ProductStatus.loading,
      builder: (context, state) {
        if (state.status != ProductStatus.success) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return ProductView(
          categories: state.categories,
        );
      },
    );
  }
}
