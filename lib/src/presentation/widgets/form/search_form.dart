import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchForm extends ConsumerStatefulWidget {
  const SearchForm({super.key});

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends ConsumerState<SearchForm> {
  final _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return TextField(
            cursorColor:Theme.of(context).iconTheme.color,
              focusNode: _focusNode,
              controller: _searchController,
              onChanged: (value) {
                ref.read(foodListProvider.notifier).searchFoods(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(Icons.search),
                  hintText:
                      AppLocalizations.of(context)?.search_box ?? 'Search...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))));
        }),
      ),
    );
  }
}
