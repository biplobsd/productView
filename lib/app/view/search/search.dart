import 'package:flutter/material.dart';
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

  final String title = 'Lays Classic Family';
  final String imgUrl =
      'https://d1ojphegpburrh.cloudfront.net/media/images/product/None/1383/%E0%A6%B8%E0%A6%9C_4.png';
  final String price = '20.00';

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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
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
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imgUrl,
            ),
            Text(
              title,
            ),
            Row(
              children: [
                const Text('মূল্য '),
                Text('৳ $price'),
              ],
            ),
            Row(
              children: [
                const Text('মূল্য '),
                Text('৳ $price'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
