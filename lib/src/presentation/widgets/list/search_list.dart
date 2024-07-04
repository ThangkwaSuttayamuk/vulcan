import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchList extends ConsumerWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(foodListProvider);
    return Consumer(
        builder: (BuildContext context, WidgetRef refHome, Widget? widget) {
      switch (searchState.searchStatus) {
        case HomeStatus.loading:
          return const Expanded(
            child: ShimmerView(
              length: 8,
            ),
          );
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
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                // crossAxisCount: 2,
                crossAxisSpacing: 20.h,
                mainAxisSpacing: 40.w, maxCrossAxisExtent: 180.w,
              ),
              itemCount: searchState.searchfoods?.length,
              itemBuilder: (context, index) {
                final foodItem = searchState.searchfoods?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: foodItem?.id);
                  },
                  child: FoodCard(
                    id: foodItem?.id ?? 0,
                    name: foodItem?.name ?? '',
                    description: foodItem?.description ?? '',
                    price: foodItem?.price ?? 0.0,
                    ingredients: foodItem?.ingredients ?? '',
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
