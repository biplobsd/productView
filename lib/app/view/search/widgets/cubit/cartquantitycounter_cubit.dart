import 'package:bloc/bloc.dart';

part 'cartquantitycounter_state.dart';

class CartquantitycounterCubit extends Cubit<CartquantitycounterState> {
  CartquantitycounterCubit()
      : super(CartquantitycounterState(slang: '', counts: {}));

  void enable({required String slang, int count = 0}) {
    state.counts[slang] = count;
    state.slang = slang;

    emit(CartquantitycounterState(slang: state.slang, counts: state.counts));
  }

  bool refresh(String slang, int count) {
    if (!state.counts.containsKey(slang)) {
      state.counts[slang] = 1;
    }
    if (count <= 0) {
      state.counts[slang] = 1;
      emit(CartquantitycounterState(slang: slang, counts: state.counts));
      return false;
    }
    state.counts[slang] = count;
    emit(CartquantitycounterState(slang: slang, counts: state.counts));
    return true;
  }
}
