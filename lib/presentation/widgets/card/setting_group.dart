import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/card/setting_card.dart';

class SettingGroup extends StatelessWidget {
  final String header;
  final List<String> setting;
  const SettingGroup({super.key, required this.setting, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Row(
            children: [
              Text(header),
            ],
          ),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              setting.length,
              (i) {
                return SettingCard(
                    name: setting[i], checkIndex: i != setting.length - 1);
              },
            )),
      ],
    );
  }
}
