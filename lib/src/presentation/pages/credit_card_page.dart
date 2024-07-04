import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/sceneshot_locker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  late ScreenshotLocker _screenshotLocker;
  @override
  void initState() {
    _screenshotLocker = ScreenshotLocker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenshotLocker.disableScreenshots();

    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 60),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          _screenshotLocker.enableScreenshots();
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)?.credit_card_header ?? 'My Card',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30)),
            height: 200.h,
            width: 350.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage('assets/images/chip.png')),
                  Text(
                    '1234 5678 1234 5678',
                    style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
