import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:productview/app/view/search/models/product_details.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String pathName = '/search';

  @override
  Widget build(BuildContext context) {
    return const SearchPageScreen();
  }
}

class SearchPageScreen extends StatelessWidget {
  const SearchPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: MasonryGridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                itemCount: productDetails.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ProductWidget(
                    imgUrl: productDetails[index].imageUrl,
                    title: productDetails[index].title,
                    price: productDetails[index].price,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final double price;

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
              imgUrl,
              fit: BoxFit.cover,
              // height: 70,
            ),
          ),
          Text(title,
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
                    '৳ $price',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                '৳ $price',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.red,
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
                    '৳ $price',
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
                    '৳ $price',
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
        ],
      ),
    );
  }
}
