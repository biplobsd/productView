import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.image,
    required this.productName,
    required this.currentCharge,
    required this.discountCharge,
    required this.sellingPrice,
    required this.profit,
  }) : super(key: key);

  final String image;
  final String productName;
  final double currentCharge;
  final double discountCharge;
  final double sellingPrice;
  final double profit;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              image,
              fit: BoxFit.cover,
              // height: 70,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(productName,
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
                    '৳ ${currentCharge.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(218, 32, 121, 1),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                '৳ ${discountCharge.toStringAsFixed(2)}',
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
                    '৳ ${sellingPrice.toStringAsFixed(2)}',
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
                    '৳ ${profit.toStringAsFixed(2)}',
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
    );
  }
}