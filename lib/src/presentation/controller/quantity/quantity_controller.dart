import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityNotifier extends StateNotifier<QuantityState> {
  QuantityNotifier() : super(QuantityState(quantity: 1));

  void initData() {
    state = state.copyWith(quantity: 1);
  }

  void decrease() {
    state.quantity > 1
        ? state = state.copyWith(quantity: state.quantity-1)
        : null;
  }

  void increase() {
    state.quantity >= 1
        ? state = state.copyWith(quantity: state.quantity+1)
        : null;
  }
}
