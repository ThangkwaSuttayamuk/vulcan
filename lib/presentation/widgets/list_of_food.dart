import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'card/food_card.dart';

class ListOfFood extends ConsumerWidget {
  const ListOfFood({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding:
      const EdgeInsets.only(bottom: 100, left: 20, right: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 40,
          childAspectRatio: 0.85),
      itemCount: 5,
      itemBuilder: (context, int i) {
        return FoodCard();
      },
    );
  }
}
