import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateCartModal extends ConsumerWidget {
  const UpdateCartModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)?.detail_update_exit_question ??
                            "Do you really want to discard this change?",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        // AppLocalizations.of(context)?.cart_adrdess ??
                        //     'Delivery Address:',
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue.shade800,
                                )),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)?.detail_update_exit_no ??
                                          "No",
                                      style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 14.sp),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/cart',ModalRoute.withName('/loading'));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)?.detail_update_exit_yes ??
                                      'Yes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
