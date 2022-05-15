import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productview/app/view/product_details/product_details.dart';
import 'package:productview/app/view/search/widgets/cubit/cartquantitycounter_cubit.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:productview/core/themes/app_theme.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return ProductItemStracture(productItem: productItem);
  }
}

class ProductItemStracture extends StatelessWidget {
  const ProductItemStracture({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartquantitycounterCubit>(context)
        .state
        .counts[productItem.slug] = productItem.cartquantity;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: InkWell(
            onTap: () {
              if (productItem.stock != 0) {
                Navigator.of(context).pushNamed(
                  ProductDetailsPage.pathName,
                  arguments: productItem,
                );
              } else {
                Fluttertoast.showToast(msg: 'Product is stock out!');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FancyShimmerImage(
                      imageUrl: productItem.image,
                      boxFit: BoxFit.scaleDown,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    productItem.productName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.black87.withOpacity(
                            0.75,
                          ),
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ক্রয় ',
                            style: GoogleFonts.balooDa2(
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            '৳ ${productItem.currentCharge.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '৳ ${productItem.discountCharge.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.lightSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'বিক্রয় ',
                            style: GoogleFonts.balooDa2(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.lightBlackColor,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            '৳ ${productItem.sellingPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppTheme.lightBlackColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'লাভ ',
                            style: GoogleFonts.balooDa2(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.lightBlackColor,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            '৳ ${productItem.profit.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppTheme.lightBlackColor,
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
          ),
        ),
        if (productItem.stock == 0)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              decoration: const BoxDecoration(
                color: Color(0xffFFCCE4),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 4),
                child: Text(
                  'স্টকে নেই',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: const Color.fromRGBO(198, 40, 40, 1),
                      ),
                ),
              ),
            ),
          )
        else
          BlocBuilder<CartquantitycounterCubit, CartquantitycounterState>(
            builder: (context, state) {
              if (productItem.isEnable == false ||
                  !state.slang.contains(productItem.slug)) {
                return Positioned(
                  bottom: 5,
                  child: CartQuantityIcDc(
                    callBack: () {
                      productItem.isEnable = true;
                      BlocProvider.of<CartquantitycounterCubit>(context).enable(
                          slang: productItem.slug,
                          count: state.counts[productItem.slug] ?? 1);
                    },
                    colors: const [
                      Color.fromRGBO(98, 16, 225, 1),
                      Color.fromRGBO(20, 0, 174, 1)
                    ],
                    icon: Icons.add,
                    size: 35,
                  ),
                );
              } else {
                return Positioned(
                  bottom: 5,
                  child: CouterQuantityWidget(
                    callback1: () {
                      var value = state.counts[productItem.slug] ?? 1;

                      if (!BlocProvider.of<CartquantitycounterCubit>(
                        context,
                      ).refresh(
                        productItem.slug,
                        value -= 1,
                      )) {
                        productItem.isEnable = false;
                      }
                    },
                    quantityText: '${state.counts[productItem.slug]}  পিস',
                    callback2: () {
                      var value = state.counts[productItem.slug] ?? 1;

                      BlocProvider.of<CartquantitycounterCubit>(
                        context,
                      ).refresh(
                        productItem.slug,
                        value += 1,
                      );
                    },
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}

class CouterQuantityWidget extends StatelessWidget {
  const CouterQuantityWidget({
    required this.callback1,
    required this.callback2,
    required this.quantityText,
    Key? key,
  }) : super(key: key);
  final Function callback1;
  final Function callback2;
  final String quantityText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(3.5),
      decoration: const BoxDecoration(
        color: Color(0xffFFCCE4),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartQuantityIcDc(
            callBack: callback1,
            colors: const [Color(0xffFFBFDD), Color(0xffFFBFDD)],
            icon: Icons.remove,
            size: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          FittedBox(
            child: Text(
              quantityText,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: const Color(0xffDA2079).withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CartQuantityIcDc(
            callBack: callback2,
            colors: const [Color(0xff6210E1), Color(0xff2503B9)],
            icon: Icons.add,
            size: 25,
          ),
        ],
      ),
    );
  }
}

class CartQuantityIcDc extends StatelessWidget {
  const CartQuantityIcDc({
    required this.callBack,
    required this.colors,
    required this.icon,
    required this.size,
    Key? key,
  }) : super(key: key);
  final Function callBack;
  final List<Color> colors;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 31,
      onTap: () {
        callBack();
      },
      child: IgnorePointer(
        child: Container(
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
