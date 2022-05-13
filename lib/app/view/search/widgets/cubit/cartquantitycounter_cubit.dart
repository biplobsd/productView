import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cartquantitycounter_state.dart';

class CartquantitycounterCubit extends Cubit<CartquantitycounterState> {
  CartquantitycounterCubit() : super(CartquantitycounterInitial());
  int count = 1;

  void enable({int count = 0}) {
    this.count = count;
    emit(CartquantitycounterEnable());
  }

  void disable() => emit(CartquantitycounterDisable());

  bool refresh(int count) {
    if (count <= 0) {
      emit(CartquantitycounterDisable());
      this.count = 1;
      return false;
    }
    this.count = count;
    emit(CartquantitycounterCount());
    return true;
  }
}
