import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer.dart';
import 'package:flutter_application_1/src/presentation/widgets/form/search_animated.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/food_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button/dragable_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _filter = [
    "burger",
    "pizza",
    "bread",
    "salad",
    "fried_chicken"
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodListProvider.notifier).fetchFoods();
      ref.read(cartProvider.notifier).cartFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodStatus =
        ref.watch(foodListProvider.select((value) => value.status));
    final filterName =
        ref.watch(filterProvider.select((value) => value.filterName));
    final cartList = ref.watch(cartProvider.select((value) => value.cartList));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomScrollView(
                physics: foodStatus == HomeStatus.loading
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.home_header ??
                                'Cashier',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Row(
                            children: [
                              const RegularIconButton(name: "cart"),
                              SizedBox(
                                width: 5.w,
                              ),
                              const RegularIconButton(name: "favorite"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SearchAnimated(),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10.h,
                    ),
                  ),
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    automaticallyImplyLeading: false,
                    pinned: filterName == '' ? false : true,
                    stretch: false,
                    flexibleSpace: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          _filter.length,
                          (index) {
                            return FilterButton(filters: _filter, index: index);
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 20.h,
                    ),
                  ),
                  const FoodList(),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 110.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Footer(),
        // const DragableButton(),
      ],
    );
  }
}
