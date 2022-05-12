import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:productview/app/view/search/cubit/searchfetch_cubit.dart';
import 'package:productview/app/view/search/widgets/product_item.dart';
import 'package:productview/core/rest_api/models/product_item.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String pathName = '/search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchfetchCubit(),
      child: const SearchPageScreen(),
    );
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
              onSubmitted: ((value) =>
                  BlocProvider.of<SearchfetchCubit>(context).search(value)),
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
            BlocBuilder<SearchfetchCubit, SearchfetchState>(
              builder: (context, state) {
                if (state is SearchfetchedState) {
                  var productDetails =
                      BlocProvider.of<SearchfetchCubit>(context).result;
                  return Expanded(
                    child: MasonryGridView.count(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2,
                      itemCount: productDetails.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ProductItemWidget(
                          productItem: ProductItem(
                            image: productDetails[index].image,
                            productName: productDetails[index].productName,
                            currentCharge: productDetails[index].currentCharge,
                            discountCharge:
                                productDetails[index].discountCharge,
                            sellingPrice: productDetails[index].sellingPrice,
                            profit: productDetails[index].profit,
                            slug: productDetails[index].slug,
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SearchfetchingState) {
                  return const CircularProgressIndicator();
                } else if (state is SearchfetchErrorState) {
                  return const Text(
                      'An error raise when fetching data from api.');
                } else if (state is SearchfetchedNoDataState) {
                  return const Text('No data found. Try again...');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
