import 'package:flutter/material.dart';
import 'package:productview/app/view/product_details/product_details.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailsPage.pathName,
          arguments: productItem,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                productItem.image,
                fit: BoxFit.cover,
                // height: 70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(productItem.productName,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'ক্রয় ',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 5,
                          ),
                    ),
                    Text(
                      '৳ ${productItem.currentCharge.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 12,
                            color: const Color.fromRGBO(218, 32, 121, 1),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Text(
                  '৳ ${productItem.discountCharge.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: const Color.fromRGBO(218, 32, 121, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'বিক্রয় ',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 5,
                          ),
                    ),
                    Text(
                      '৳ ${productItem.sellingPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 10,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'লাভ ',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 5,
                          ),
                    ),
                    Text(
                      '৳ ${productItem.profit.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 10,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
