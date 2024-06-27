import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButton extends ConsumerWidget {
  final List<String> filters;
  final int index;

  const FilterButton({Key? key, required this.filters, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    final theme = ref.watch(themeProvider);

    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: theme.theme ? Colors.transparent : Colors.blue.shade800,
            width: 2.w,
          )),
      color: filterState.filterName == filters[index]
          ? Colors.white
          : theme.theme
              ? Theme.of(context).colorScheme.secondary
              : Colors.blue.shade800,
      // borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          final selectedFilter = filters[index];

          ref.read(filterProvider.notifier).setFilter(selectedFilter);

          if (filterState.filterName == selectedFilter) {
            ref.read(foodListProvider.notifier).filterFoodsByCategory('');
          } else {
            ref
                .read(foodListProvider.notifier)
                .filterFoodsByCategory(selectedFilter);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/icon_${filterState.filterName == filters[index] && theme.theme ? filters[index] + "_active_dark" : filterState.filterName == filters[index] ? filters[index] + "_active" : filters[index]}.png',
            height: 40.h,
            width: 40.h,
          ),
        ),
      ),
    );
  }
}
