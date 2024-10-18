import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prosoft_task/api/product/models/product.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.center,
      this.onProductPressed})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onProductPressed;

  @override
  Widget build(BuildContext context) {
    final onSales = product.discountPercentage! != 0;
    final priceValue = product.price! * product.discountPercentage!;
    // ? product.discountPercentage?
    // : ;
    final crossedValue = onSales ? product.price : null;
    return GestureDetector(
      onTap: () {
        onProductPressed?.call(product.id.toString());
      },
      child: SizedBox(
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network('${product.thumbnail}',
                      alignment: imageAlignment, fit: BoxFit.cover)),
              if (onSales == true)
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      " ON SALE ${product.discountPercentage}% ",
                      // style: Theme.of(context).textTheme.caption?.copyWith(
                      //       color: Colors.white,
                      //       backgroundColor: AppTheme.darkPink,
                      //     ),
                    ))
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.brand}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption),
                Text('${product.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText1),
                if (product.description?.isNotEmpty == true)
                  Text('${product.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(fontSize: 12, color: Colors.grey)),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 2.0),
                //   child: ColorIndicatorView(product: product),
                // ),
                Row(
                  children: [
                    Text('$priceValue €',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: AppTheme.vividOrange,
                            )),
                    if (crossedValue != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('$crossedValue €',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    decoration: TextDecoration.lineThrough)),
                      ),
                  ],
                ),
                // RatingView(
                //     value: product.reviews?.rating?.toInt() ?? 0,
                //     reviewsCount: product.reviews?.count?.toInt() ?? 0),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
