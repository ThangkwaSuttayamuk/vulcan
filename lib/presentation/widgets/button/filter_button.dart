import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final List<String> filter;
  final int index;
  const FilterButton({super.key, required this.filter, required this.index});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool _checkFilter = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Color.fromARGB(190, 13, 72, 161),
            width: _checkFilter ? 2 : 0,
          )),
      color: _checkFilter ? Colors.white : Color.fromARGB(190, 13, 72, 161),
      // borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _checkFilter = !_checkFilter;
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/icon_${_checkFilter ? widget.filter[widget.index] + "_active" : widget.filter[widget.index]}.png',
            height: 40,
          ),
        ),
      ),
    );
  }
}
