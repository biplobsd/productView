import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:productview/app/view/search/widgets/product_item.dart';
import 'package:productview/core/rest_api/cubit/restapi_cubit.dart';

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
            BlocBuilder<RestapiCubit, RestapiState>(
              builder: (context, state) {
                if (state is RestapiInitial) {
                  BlocProvider.of<RestapiCubit>(context).testGet('rice');
                }
                if (state is RestapiFetchedSearchState) {
                  return const Text('Data Fetched');
                }
                return Container();
              },
            )
            // Expanded(
            //   child: MasonryGridView.count(
            //     mainAxisSpacing: 15,
            //     crossAxisSpacing: 15,
            //     crossAxisCount: 2,
            //     itemCount: productDetails.length,
            //     itemBuilder: (BuildContext ctx, index) {
            //       return ProductItem(
            //         image: productDetails[index].imageUrl,
            //         productName: productDetails[index].title,
            //         price: productDetails[index].price,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
