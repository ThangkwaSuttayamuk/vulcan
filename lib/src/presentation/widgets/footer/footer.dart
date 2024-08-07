import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Footer extends ConsumerStatefulWidget {
  const Footer({
    super.key,
  });

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends ConsumerState<Footer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 6,
              blurRadius: 7,
              offset: Offset(0, 10),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FooterButton(
              name: "home",
              title: AppLocalizations.of(context)?.footer_home ?? 'home',
            ),
            FooterButton(
              name: "order",
              title: AppLocalizations.of(context)?.footer_order ?? 'order',
            ),
            FooterButton(
              name: "message",
              title: AppLocalizations.of(context)?.footer_message ?? 'message',
            ),
            FooterButton(
              name: "setting",
              title: AppLocalizations.of(context)?.footer_setting ?? 'setting',
            )
          ],
        ),
      ),
    );
  }
}
