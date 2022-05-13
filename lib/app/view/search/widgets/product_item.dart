import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productview/app/view/product_details/product_details.dart';
import 'package:productview/app/view/search/widgets/cubit/cartquantitycounter_cubit.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartquantitycounterCubit(),
      child: ProductItemStracture(productItem: productItem),
    );
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
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        InkWell(
          onTap: () {
            if (productItem.stock != 0) {
              productItem.cartquantity =
                  BlocProvider.of<CartquantitycounterCubit>(context).count;
              Navigator.of(context).pushNamed(
                ProductDetailsPage.pathName,
                arguments: productItem,
              );
            } else {
              Fluttertoast.showToast(msg: 'Product is stock out!');
            }
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
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600)),
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
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 5,
                                  ),
                        ),
                        Text(
                          '৳ ${productItem.currentCharge.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
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
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 5,
                                  ),
                        ),
                        Text(
                          '৳ ${productItem.sellingPrice.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 5,
                                  ),
                        ),
                        Text(
                          '৳ ${productItem.profit.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
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
        ),
        productItem.stock == 0
            ? Positioned(
                top: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  decoration: const BoxDecoration(
                      color: Color(0xffFFCCE4),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 4),
                    child: Text(
                      'স্টকে নেই',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: const Color.fromRGBO(198, 40, 40, 1),
                          ),
                    ),
                  ),
                ),
              )
            : BlocBuilder<CartquantitycounterCubit, CartquantitycounterState>(
                builder: (context, state) {
                  if ((state is CartquantitycounterDisable ||
                          state is CartquantitycounterInitial) &&
                      productItem.isEnable == false) {
                    return Positioned(
                      bottom: -15,
                      child: CartQuantityIcDc(
                        callBack: () {
                          productItem.isEnable = true;
                          BlocProvider.of<CartquantitycounterCubit>(context)
                              .enable(count: productItem.cartquantity);
                        },
                        colors: const [Color(0xff6210E1), Color(0xff2503B9)],
                        icon: Icons.add,
                        size: 35,
                      ),
                    );
                  } else {
                    return Positioned(
                      bottom: -20,
                      child: CouterQuantityWidget(
                        callback1: () {
                          if (!BlocProvider.of<CartquantitycounterCubit>(
                                  context)
                              .refresh(
                            BlocProvider.of<CartquantitycounterCubit>(context)
                                .count -= 1,
                          )) {
                            productItem.isEnable = false;
                          }
                        },
                        quantityText:
                            '${BlocProvider.of<CartquantitycounterCubit>(context).count}  পিস',
                        callback2: () {
                          BlocProvider.of<CartquantitycounterCubit>(context)
                              .refresh(
                            BlocProvider.of<CartquantitycounterCubit>(context)
                                .count += 1,
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
                  fontWeight: FontWeight.bold),
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
      onTap: () {
        callBack();
      },
      child: Container(
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: FittedBox(
          child: Container(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                icon,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
