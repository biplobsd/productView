class ProductItem {
  final String image;
  final String productName;
  final double currentCharge;
  final double discountCharge;
  final double sellingPrice;
  final double profit;
  final String slug;

  ProductItem({
    required this.image,
    required this.productName,
    required this.currentCharge,
    required this.discountCharge,
    required this.sellingPrice,
    required this.profit,
    required this.slug,
  });

  @override
  String toString() {
    return 'Product(image: $image, productName: $productName, currentCharge: $currentCharge, discountCharge: $discountCharge, sellingPrice: $sellingPrice, profit: $profit, slug: $slug)';
  }
}
