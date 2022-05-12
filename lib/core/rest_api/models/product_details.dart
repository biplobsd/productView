class Product {
  final String image;
  final String productName;
  final double currentCharge;
  final double discountCharge;
  final double sellingPrice;
  final double profit;

  Product({
    required this.image,
    required this.productName,
    required this.currentCharge,
    required this.discountCharge,
    required this.sellingPrice,
    required this.profit,
  });

  @override
  String toString() {
    return 'Product(image: $image, productName: $productName, currentCharge: $currentCharge, discountCharge: $discountCharge, sellingPrice: $sellingPrice, profit: $profit)';
  }
}
