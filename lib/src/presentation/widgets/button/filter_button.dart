import 'package:flutter/material.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
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
    final assets = const $AssetsImagesGen();

    final assetImage = getAssetImage(filters[index], theme.theme, assets,
        filterState.filterName == filters[index]);

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
          child: 
          assetImage.image(
            height: 40,
            width: 40,
          ),
        ),
      ),
    );
  }

  AssetGenImage getAssetImage(String filterName, bool isDarkTheme,
      $AssetsImagesGen assets, bool isActive) {
    switch (filterName) {
      case 'bread':
        return isDarkTheme && isActive
            ? assets.iconBreadActiveDark
            : isActive
                ? assets.iconBreadActive
                : assets.iconBread;
      case 'burger':
        return isDarkTheme && isActive
            ? assets.iconBurgerActiveDark
            : isActive
                ? assets.iconBurgerActive
                : assets.iconBurger;
      case 'fried_chicken':
        return isDarkTheme && isActive
            ? assets.iconFriedChickenActiveDark
            : isActive
                ? assets.iconFriedChickenActive
                : assets.iconFriedChicken;
      case 'salad':
        return isDarkTheme && isActive
            ? assets.iconSaladActiveDark
            : isActive
                ? assets.iconSaladActive
                : assets.iconSalad;
      case 'pizza':
        return isDarkTheme && isActive
            ? assets.iconPizzaActiveDark
            : isActive
                ? assets.iconPizzaActive
                : assets.iconPizza;
      default:
        return assets.iconBurger; // Default case
    }
  }
}
