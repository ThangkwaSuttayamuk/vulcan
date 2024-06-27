import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/form/search_form.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/search_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodListProvider.notifier).initSearch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Consumer(builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child:  const  Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              )));
                    })),
                const  SearchForm(),
              ],
            ),
          ),
          const SearchList()
        ],
      )),
    );
  }
}
