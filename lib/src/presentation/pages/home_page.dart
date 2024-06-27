import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';

import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/search_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/food_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<String> _filter = [
    "burger",
    "pizza",
    "bread",
    "salad",
    "fried_chicken"
  ];

  late SharedPreferences loginData;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodListProvider.notifier).fetchFoods();
    });
    super.initState();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState(() {});
  }

  late DatabaseHelper databaseHelper;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
                child: Column(
                  children: [
                    Row(
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: SizedBox(
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
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)?.home_menu ?? 'Menu',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const FoodList()
            ],
          ),
        ),
        const Footer()
      ],
    );
  }
}
