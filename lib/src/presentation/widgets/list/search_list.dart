import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchList extends ConsumerWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(foodListProvider);
    return Consumer(
        builder: (BuildContext context, WidgetRef refHome, Widget? widget) {
      switch (searchState.searchStatus) {
        case HomeStatus.loading:
          return Expanded(child: Center(child: CircularProgressIndicator()));
        case HomeStatus.failure:
          return Expanded(
              child: Center(child: Text('Error: ${searchState.error}')));
        case HomeStatus.empty:
          return Expanded(
              child: Center(
                  child: Text(
            AppLocalizations.of(context)?.search_empty ?? 'Not Found',
          )));
        case HomeStatus.success:
          return Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
                childAspectRatio: (MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height) /
                    0.5,
              ),
              itemCount: searchState.searchfoods?.length,
              itemBuilder: (context, index) {
                final foodItem = searchState.searchfoods?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => FoodDetail(
                                  id: foodItem?.id ?? 0,
                                  name: foodItem?.name ?? '',
                                  description: foodItem?.description ?? '',
                                  price: foodItem?.price ?? 0.0,
                                  image: foodItem?.image ?? '',
                                )));
                  },
                  child: FoodCard(
                    id: foodItem?.id ?? 0,
                    name: foodItem?.name ?? '',
                    description: foodItem?.description ?? '',
                    price: foodItem?.price ?? 0.0,
                    image: foodItem?.image ?? '',
                  ),
                );
              },
            ),
          );
        default:
          return Expanded(
              child: Center(
            child: Text(
              AppLocalizations.of(context)?.search_initial ??
                  'Search For Result',
            ),
          ));
      }
    });
  }
}
