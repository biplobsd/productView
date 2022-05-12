import 'package:productview/core/rest_api/models/product_item.dart';

class ProductDetail extends ProductItem {
  ProductDetail(
      {required String image,
      required String productName,
      required double currentCharge,
      required double discountCharge,
      required double sellingPrice,
      required double profit,
      required String slug,
      required this.description,
      required this.brandName,
      required this.seller})
      : super(
            image: image,
            productName: productName,
            currentCharge: currentCharge,
            discountCharge: discountCharge,
            sellingPrice: sellingPrice,
            profit: profit,
            slug: slug);
  final String description;
  final String brandName;
  final String seller;
}
