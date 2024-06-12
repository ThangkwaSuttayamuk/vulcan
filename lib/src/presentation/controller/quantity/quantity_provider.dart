import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quantityProvider =
    StateNotifierProvider.autoDispose<QuantityNotifier, QuantityState>((ref) {
  return QuantityNotifier();
});
