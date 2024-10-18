import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prosoft_task/product/bloc/product_bloc.dart';
import 'package:prosoft_task/product/widgets/gird_product.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 0,
      length: widget.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Product',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontFamily: GoogleFonts.lora().fontFamily,
                ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
            onTap: (value) => context
                .read<ProductBloc>()
                .add(CategoryChanged(widget.categories[value])),
            tabs: widget.categories
                .map((e) => Tab(
                      child: Text(e),
                    ))
                .toList(),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) => previous != current,
          builder: (_, state) => state.status == ProductStatus.loading
              ? const Center(child: CupertinoActivityIndicator())
              : GridProduct(products: state.products),
        ),
      ),
    );
  }
}
