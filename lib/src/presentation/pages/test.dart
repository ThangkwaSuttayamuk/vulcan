import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/filter/filter_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/pages/search_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/test_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
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
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodList = ref.watch(foodListProvider);
    final filterState = ref.watch(filterProvider);
    final filter = filterState.filterName;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                physics: foodList.status == HomeStatus.loading
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
                            // color: Colors.blue.shade800
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
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    automaticallyImplyLeading: false,
                    floating: true, //show this widget when scroll down
                    pinned: true, //stay still this widget
                    elevation: 0,
                    stretch: false,
                    flexibleSpace: SizedBox(
                        height: 50.h,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const SearchPage())),
                          child: AbsorbPointer(
                            child: TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.secondary,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: AppLocalizations.of(context)
                                            ?.home_search ??
                                        'Search...',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)))),
                          ),
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 10.h,
                    ),
                  ),
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    automaticallyImplyLeading: false,
                    pinned: filter == '' ? false : true,
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
                  const TestList(),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 70.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Footer()
      ],
    );
  }
}
