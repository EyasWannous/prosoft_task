import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Placeholder(
            fallbackHeight: 10,
            fallbackWidth: 10,
          ),
          Text(title),
          // Text(description),
          Text(price.toString()),
          Text(discountPercentage.toString()),
          Text(rating.toString()),
          // Text(stock.toString()),
          Text(brand),
          // Text(category),
          // Text(thumbnail),
          // ...images.map((e) => Text(e))
        ],
      ),
    );
  }
}
