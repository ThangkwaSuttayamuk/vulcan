import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final String name;
  final bool checkIndex;
  const SettingCard({super.key, required this.name, required this.checkIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                //
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        checkIndex
            ? Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
                height: 0,
              )
            : SizedBox()
      ],
    );
  }
}
