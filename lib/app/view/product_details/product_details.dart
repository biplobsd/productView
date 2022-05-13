import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:productview/app/view/product_details/cubit/productfetch_cubit.dart';
import 'package:productview/app/view/search/search.dart';
import 'package:productview/app/view/search/widgets/cubit/cartquantitycounter_cubit.dart';
import 'package:productview/app/view/search/widgets/product_item.dart';
import 'package:productview/app/view/search/widgets/searchbar.dart';
import 'package:productview/core/cubit/maincart_cubit.dart';
import 'package:productview/core/rest_api/models/product_details.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.productItem, Key? key})
      : super(key: key);
  static const String pathName = '/productdetails';
  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductfetchCubit(productItem: productItem),
        ),
        BlocProvider(
          create: (context) => CartquantitycounterCubit(),
        ),
      ],
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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'প্রোডাক্ট ডিটেইল',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ProductfetchCubit, ProductfetchState>(
        builder: (context, state) {
          if (state is ProductfetchingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductfetchedState ||
              state is ProductfetchedNoDataState) {
            return ProductDetailPageWidge(
              productDetail: BlocProvider.of<ProductfetchCubit>(context).result,
            );
          } else if (state is ProducterrorState) {
            return const Text('Fetching detail on error');
          }
          return const Text('Unknown state');
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductDetailPageWidge extends StatelessWidget {
  ProductDetailPageWidge({
    required this.productDetail,
    Key? key,
  }) : super(key: key);

  final ProductDetail productDetail;
  bool isBuyed = false;

  @override
  Widget build(BuildContext context) {
    final customTextStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleSmall!.color!.withOpacity(
                0.75,
              ),
        );
    BlocProvider.of<CartquantitycounterCubit>(context).count =
        productDetail.cartquantity;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchbarWidget(
              searchbarController: TextEditingController(),
              onSubmitted: (String value) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SearchPage.pathName,
                  (route) => false,
                  arguments: value,
                );
              },
            ),
          ),
          CarouselSlider.builder(
            itemCount: productDetail.images.length,
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: FancyShimmerImage(
                  imageUrl: productDetail.images[index],
                  boxFit: BoxFit.scaleDown,
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDetail.productName,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      'ব্রান্ডঃ ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Flexible(
                      child: Text(
                        productDetail.brandName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 7,
                      color: Color.fromRGBO(218, 32, 121, 1),
                    ),
                    Text(
                      ' ডিস্ট্রিবিউটরঃ ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Flexible(
                      child: Text(
                        productDetail.seller,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ক্রয়মূল্যঃ',
                                      style: customTextStyle.copyWith(
                                        color: const Color.fromRGBO(
                                          218,
                                          32,
                                          121,
                                          1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '৳ ${productDetail.currentCharge.toStringAsFixed(0)}',
                                      style: customTextStyle.copyWith(
                                        color: const Color.fromRGBO(
                                          218,
                                          32,
                                          121,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'বিক্রয়মূল্যঃ',
                                          style: customTextStyle,
                                        ),
                                        Text(
                                          '৳ ${productDetail.sellingPrice.toStringAsFixed(0)}',
                                          style: customTextStyle,
                                        ),
                                      ],
                                    ),
                                    if (productDetail.isEnable)
                                      BlocBuilder<CartquantitycounterCubit,
                                          CartquantitycounterState>(
                                        builder: (context, state) {
                                          return SizedBox(
                                            width: 150,
                                            child: CouterQuantityWidget(
                                              callback1: () {
                                                if (!BlocProvider.of<
                                                    CartquantitycounterCubit>(
                                                  context,
                                                ).refresh(
                                                  BlocProvider.of<
                                                      CartquantitycounterCubit>(
                                                    context,
                                                  ).count -= 1,
                                                )) {
                                                  productDetail.isEnable =
                                                      false;
                                                }
                                              },
                                              quantityText:
                                                  '${BlocProvider.of<CartquantitycounterCubit>(context).count}  পিস',
                                              callback2: () {
                                                BlocProvider.of<
                                                    CartquantitycounterCubit>(
                                                  context,
                                                ).refresh(
                                                  BlocProvider.of<
                                                      CartquantitycounterCubit>(
                                                    context,
                                                  ).count += 1,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const DottedLine(
                                  dashColor: Colors.grey,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'লাভঃ',
                                      style: customTextStyle,
                                    ),
                                    Text(
                                      '৳ ${productDetail.profit.toStringAsFixed(0)}',
                                      style: customTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'বিস্তারিত',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.75),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<MaincartCubit>(context)
                              .addItem(productDetail);
                          isBuyed = true;
                        },
                        child: BlocBuilder<MaincartCubit, MaincartState>(
                          builder: (context, state) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  height: 90,
                                  child: ClipPolygon(
                                    sides: 6,
                                    borderRadius: 10,
                                    rotate: 180,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff6210E1),
                                            Color(0xff2503B9)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: isBuyed
                                          ? FittedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/shopping_bag.png',
                                                    height: 30,
                                                  ),
                                                  const Text(
                                                    'কার্ট',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Text(
                                              'এটি\nকিনুন',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                if (BlocProvider.of<MaincartCubit>(context)
                                    .isNotEmpty)
                                  Positioned(
                                    right: -5,
                                    top: 10,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFCCE4),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        '${BlocProvider.of<MaincartCubit>(context).howMany}',
                                        style: const TextStyle(
                                          color: Color(0xffDA2079),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      HtmlParser.parseHTML(productDetail.description).text,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
