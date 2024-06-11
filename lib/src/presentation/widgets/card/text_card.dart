import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final List<String> listOfItem;

  const TextCard({super.key, required this.listOfItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 90),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 10.0,
          runSpacing: 10.0,
          children: List.generate(
              listOfItem.length,
              (index) => Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(listOfItem[index]),
                  )),
        ),
      ),
    );
  }
}
