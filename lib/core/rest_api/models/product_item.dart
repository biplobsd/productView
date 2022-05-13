class ProductItem {
  final String image;
  final String productName;
  final double currentCharge;
  final double discountCharge;
  final double sellingPrice;
  final double profit;
  final String slug;
  late int cartquantity;
  late bool isEnable;

  ProductItem({
    required this.image,
    required this.productName,
    required this.currentCharge,
    required this.discountCharge,
    required this.sellingPrice,
    required this.profit,
    required this.slug,
    this.cartquantity = 1,
    this.isEnable = false,
  });

  @override
  String toString() {
    return 'ProductItem(image: $image, productName: $productName, currentCharge: $currentCharge, discountCharge: $discountCharge, sellingPrice: $sellingPrice, profit: $profit, slug: $slug, cartquantity: $cartquantity)';
  }
}
