import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/filter_state.dart';
import 'package:flutter_application_1/src/presentation/controller/food_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterButton extends ConsumerWidget {
  final List<String> filters;
  final int index;

  const FilterButton({Key? key, required this.filters, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    final foodListState =
        ref.watch(foodListProvider); // Watch the foodListProvider

    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Color.fromARGB(190, 13, 72, 161),
            width: filterState.filterName == filters[index] ? 2 : 0,
          )),
      color: filterState.filterName == filters[index]
          ? Colors.white
          : Color.fromARGB(190, 13, 72, 161),
      // borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ref.read(filterProvider.notifier).setFilter(filters[index]);

          ref
              .read(foodListProvider.notifier)
              .filterFoodsByCategory(filterState.filterName);
          // final selectedFilter = filters[index];

          // ref.read(filterProvider.notifier).setFilter(selectedFilter);

          // if (filterState.filterName == selectedFilter) {
          //   ref.read(foodListProvider.notifier).filterFoodsByCategory('');
          // } else {
          //   ref
          //       .read(foodListProvider.notifier)
          //       .filterFoodsByCategory(selectedFilter);
          // }
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/icon_${filterState.filterName == filters[index] ? filters[index] + "_active" : filters[index]}.png',
            height: 40,
          ),
        ),
      ),
    );
  }
}

// class FilterButton extends StatefulWidget {
//   final List<String> filter;
//   final int index;
//   const FilterButton({super.key, required this.filter, required this.index});

//   @override
//   State<FilterButton> createState() => _FilterButtonState();
// }

// class _FilterButtonState extends State<FilterButton> {
//   bool _checkFilter = false;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(
//             color: Color.fromARGB(190, 13, 72, 161),
//             width: _checkFilter ? 2 : 0,
//           )),
//       color: _checkFilter ? Colors.white : Color.fromARGB(190, 13, 72, 161),
//       // borderRadius: BorderRadius.circular(10),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () {
//           _checkFilter = !_checkFilter;
//           setState(() {
//             // print(widget.filter[widget.index]);
//           });
//         },
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: Image.asset(
//             'assets/images/icon_${_checkFilter ? widget.filter[widget.index] + "_active" : widget.filter[widget.index]}.png',
//             height: 40,
//           ),
//         ),
//       ),
//     );
//   }
// }
