import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:productview/app/view/search/cubit/searchfetch_cubit.dart';
import 'package:productview/app/view/search/widgets/product_item.dart';
import 'package:productview/app/view/search/widgets/searchbar.dart';
import 'package:productview/core/rest_api/models/product_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({required this.query, Key? key}) : super(key: key);
  static const String pathName = '/search';
  final String query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchfetchCubit(query: query),
      child: SearchPageScreen(),
    );
  }
}

class SearchPageScreen extends StatelessWidget {
  SearchPageScreen({
    Key? key,
  }) : super(key: key);

  final RefreshController refreshController = RefreshController();

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
            SearchbarWidget(
              onSubmitted: (String value) =>
                  BlocProvider.of<SearchfetchCubit>(context)
                      .search(value, offset: 10, addList: false),
              query: BlocProvider.of<SearchfetchCubit>(context).query,
            ),
            const SizedBox(height: 20),
            BlocBuilder<SearchfetchCubit, SearchfetchState>(
              builder: (context, state) {
                if (state is SearchfetchingState) {
                  return const CircularProgressIndicator();
                } else if (state is SearchfetchedNoDataState) {
                  return const Text('No data to fetch');
                }

                return Container();
              },
            ),
            BlocBuilder<SearchfetchCubit, SearchfetchState>(
              builder: (context, state) {
                if (state is SearchfetchedState ||
                    state is SearchfetchingState ||
                    state is SearchfetchedNoDataState) {
                  var productDetails =
                      BlocProvider.of<SearchfetchCubit>(context).result;
                  return Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      enablePullDown: false,
                      onLoading: () async {
                        if (BlocProvider.of<SearchfetchCubit>(context).count >
                            BlocProvider.of<SearchfetchCubit>(context)
                                .result
                                .length) {
                          await BlocProvider.of<SearchfetchCubit>(context)
                              .search(
                            BlocProvider.of<SearchfetchCubit>(context).query,
                            offset: BlocProvider.of<SearchfetchCubit>(context)
                                .offset += 10,
                          );

                          refreshController.loadComplete();
                          if (BlocProvider.of<SearchfetchCubit>(context).state
                              is SearchfetchErrorState) {
                            refreshController.loadFailed();
                          }
                        } else {
                          refreshController.loadNoData();
                        }
                      },
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
                              currentCharge:
                                  productDetails[index].currentCharge,
                              discountCharge:
                                  productDetails[index].discountCharge,
                              sellingPrice: productDetails[index].sellingPrice,
                              profit: productDetails[index].profit,
                              slug: productDetails[index].slug,
                              stock: productDetails[index].stock,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is SearchfetchErrorState) {
                  return const Text(
                    'An error raise when fetching data from api.',
                  );
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
