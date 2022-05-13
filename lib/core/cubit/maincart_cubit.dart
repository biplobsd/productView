import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productview/core/rest_api/models/product_details.dart';

part 'maincart_state.dart';

class MaincartCubit extends Cubit<MaincartState> {
  MaincartCubit() : super(MaincartInitialState());

  late final List<ProductDetail> _cardProductDetail = [];

  int get howMany {
    return _cardProductDetail.length;
  }

  bool get isNotEmpty => _cardProductDetail.isNotEmpty;

  bool addItem(ProductDetail productDetail) {
    _cardProductDetail.add(productDetail);
    emit(MaincartOpenState());
    return true;
  }
}
