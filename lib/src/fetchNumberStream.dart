import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider = StreamProvider<int>((ref) {
  return fetchNumbers();
});

Stream<int> fetchNumbers() {
  return Stream<int>.periodic(Duration(seconds: 3), (number) => number)
      .take(100);
}
