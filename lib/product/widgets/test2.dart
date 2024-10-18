import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prosoft_task/api/product/models/product.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {super.key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      this.onTap});

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final onSales = product.discountPercentage! != 0;
    final priceValue = product.price! -
        ((product.price! * product.discountPercentage!) / 100).ceil();
    final crossedValue = onSales ? product.price : null;
    final theme = Theme.of(context);
    return Card.filled(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  '${product.thumbnail}',
                  alignment: imageAlignment,
                  fit: BoxFit.cover,
                ),
              ),
              if (onSales == true)
                Text(
                  " ON SALE ${product.discountPercentage}% ",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            // '  ${product.brand} ${product.title}',
            ' ${product.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            // '  ${product.brand} ${product.title}',
            ' ${product.category}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 2.0),
          // child: ColorIndicatorView(product: product),
          // ),
          // const Spacer(
          //   flex: 2,
          // ),
          12.h,
          RatingBar(
            initialRating: product.rating!,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemSize: 12,
            wrapAlignment: WrapAlignment.start,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              empty: const Icon(
                Icons.star,
                color: Colors.grey,
              ),
              half: const Icon(
                Icons.star,
                color: Colors.grey,
              ),
            ),
            onRatingUpdate: (rating) {
              // print(rating);
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 8.w,
              // Text(
              //   'rate',
              //   maxLines: 1,
              //   overflow: TextOverflow.clip,
              //   softWrap: false,
              //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //         fontWeight: FontWeight.bold,
              //       ),
              // ),
              // const Spacer(),
              Text(
                '$priceValue €',
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              4.w,
              if (crossedValue != null)
                Text(
                  '$crossedValue €',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: theme.colorScheme.error,
                        // fontSize: 8,
                      ),
                ),
              12.w,
            ],
          ),
          const Spacer(),
          // RatingView(
          //     value: product.reviews?.rating?.toInt() ?? 0,
          //     reviewsCount: product.reviews?.count?.toInt() ?? 0),
        ],
      ),
    );
  }
}
