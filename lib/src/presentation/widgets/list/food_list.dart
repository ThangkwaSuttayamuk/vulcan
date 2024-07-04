import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodList extends ConsumerWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodListState = ref.watch(foodListProvider);
    final filterState = ref.watch(filterProvider);
    final filter = filterState.filterName;
    return Consumer(
        builder: (BuildContext context, WidgetRef refHome, Widget? widget) {
      switch (foodListState.status) {
        case HomeStatus.loading:
          return const Expanded(
            child: ShimmerView(
              length: 6,
            ),
          );
        case HomeStatus.failure:
          return Expanded(
              child: Center(child: Text('Error: ${foodListState.error}')));
        case HomeStatus.empty:
          return Expanded(
              child: Center(
                  child: Text(
            AppLocalizations.of(context)?.home_empty ?? 'Not Found',
          )));
        case HomeStatus.success:
          return Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 100.h, left: 20.w, right: 20.w),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 20.h,
                mainAxisSpacing: 40.w,
                maxCrossAxisExtent: 180.w,
              ),
              itemCount: filter == ''
                  ? (foodListState.foods?.length)
                  : (foodListState.filterfoods?.length),
              itemBuilder: (context, index) {
                final foodItem = (filter == ''
                    ? (foodListState.foods?[index])
                    : (foodListState.filterfoods?[index]));
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'detail',
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
              'Not Found',
              style: TextStyle(fontSize: 14.sp),
            ),
          ));
      }
    });
  }
}
