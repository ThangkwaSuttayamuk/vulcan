import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer_button.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FooterButton(name: "favorite",),
            FooterButton(name: "home",),
            FooterButton(name: "setting",)
          ],
        ),
      ),
    );
  }
}
