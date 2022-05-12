import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productview/app/view/product_details/cubit/productfetch_cubit.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.slug, Key? key}) : super(key: key);
  static const String pathName = '/productdetails';
  final ProductItem slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductfetchCubit(productItem: slug),
      child: const ProductDetailsPageScreen(),
    );
  }
}

class ProductDetailsPageScreen extends StatelessWidget {
  const ProductDetailsPageScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'প্রোডাক্ট ডিটেলস',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ProductfetchCubit, ProductfetchState>(
        builder: (context, state) {
          if (state is ProductfetchingState) {
            return const CircularProgressIndicator();
          } else if (state is ProductfetchedState ||
              state is ProductfetchedNoDataState) {
            return ProductDetailPageWidge(
                productDetail:
                    BlocProvider.of<ProductfetchCubit>(context).result);
          } else if (state is ProducterrorState) {
            return const Text('Fetching detail on error');
          }
          return const Text('Unknown state');
        },
      ),
    );
  }
}

class ProductDetailPageWidge extends StatelessWidget {
  const ProductDetailPageWidge({
    required this.productDetail,
    Key? key,
  }) : super(key: key);

  final ProductDetail productDetail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
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
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Image.network(
              productDetail.image,
              height: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productDetail.productName,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Text('ব্র্যান্ড:',
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                      productDetail.brandName,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 7,
                      color: Colors.redAccent,
                    ),
                    Text(' ডিস্ট্রিবিউটর: ',
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(productDetail.seller,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ক্রয়মূল্য:',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '৳ ${productDetail.currentCharge.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'বিক্রয়মূল্য:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '৳ ${productDetail.sellingPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const DottedLine(
                            dashColor: Colors.grey,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'লাভ:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '৳ ${productDetail.profit.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -35,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/img/hagon.svg',
                            height: 70,
                          ),
                          Text(
                            'এটা কিনুন',
                            style: Theme.of(context)
                                .textTheme
                                .overline!
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'বিস্তারিত',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  productDetail.description,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
