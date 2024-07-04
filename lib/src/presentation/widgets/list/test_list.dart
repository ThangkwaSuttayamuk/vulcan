import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestList extends ConsumerWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodListState = ref.watch(foodListProvider);
    final filterState = ref.watch(filterProvider);
    final filter = filterState.filterName;
    switch (foodListState.status) {
      case HomeStatus.success:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final foodItem = (filter == ''
                  ? (foodListState.foods?[index])
                  : (foodListState.filterfoods?[index]));
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
            childCount: filter == ''
                ? (foodListState.foods?.length)
                : (foodListState.filterfoods?.length),
          ),
        );
      case HomeStatus.loading:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShimmerBox();
            },
            childCount: filter == ''
                ? (foodListState.foods?.length)
                : (foodListState.filterfoods?.length),
          ),
        );

      case HomeStatus.initial:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShimmerBox();
            },
            childCount: filter == ''
                ? (foodListState.foods?.length)
                : (foodListState.filterfoods?.length),
          ),
        );

      case HomeStatus.empty:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ShimmerBox();
          }, childCount: 8),
        );

      case HomeStatus.failure:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShimmerBox();
            },
            childCount: filter == ''
                ? (foodListState.foods?.length)
                : (foodListState.filterfoods?.length),
          ),
        );

      default:
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 20.h,
            mainAxisSpacing: 30.w,
            maxCrossAxisExtent: 180.w,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ShimmerBox();
            },
            childCount: filter == ''
                ? (foodListState.foods?.length)
                : (foodListState.filterfoods?.length),
          ),
        );
    }
  }
}
