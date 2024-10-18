import 'package:flutter/material.dart';
import 'package:prosoft_task/api/product/models/models.dart';
// import 'package:prosoft_task/product/widgets/product_card.dart';
import 'package:prosoft_task/product/widgets/test2.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 2,
      ),
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      // ),
      itemCount: products.length,
      itemBuilder: (_, index) => ProductCardView(product: products[index]),
      // ProductCard(
      //   id: products[index].id ?? 0,
      //   title: products[index].title ?? 'title',
      //   description: products[index].description ?? 'description',
      //   price: products[index].price ?? 100,
      //   discountPercentage: products[index].discountPercentage ?? 100,
      //   rating: products[index].rating ?? 5,
      //   stock: products[index].stock ?? 1,
      //   brand: products[index].brand ?? 'brand',
      //   category: products[index].category ?? 'category',
      //   thumbnail: products[index].thumbnail ?? 'tumbnail',
      //   images: products[index].images ?? [],
      // ),
    );
  }
}
