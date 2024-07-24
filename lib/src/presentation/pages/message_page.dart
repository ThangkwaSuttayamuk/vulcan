import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/notification/notification_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/gen/assets.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePage extends ConsumerStatefulWidget {
  final dynamic arg;
  const MessagePage(this.arg, {super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  final assets = const $AssetsImagesGen();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).notificationList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notification = ref
        .watch(notificationProvider.select((value) => value.notificationList));
    final theme = ref.watch(themeProvider.select((value) => value.theme));

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 60),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          )),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)?.message_header ?? 'Message',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(notification?.length ?? 0, (i) {
                final notificationItem = notification?[i];

                return Material(
                  child: InkWell(
                    onTap: () {
                      print(notificationItem?.id);
                      Navigator.pushNamed(context, '/notification_detail',
                          arguments: {
                            "id": notificationItem?.id,
                            "title": notificationItem?.title,
                            "period": notificationItem?.period,
                            "description": notificationItem?.description,
                            "image": notificationItem?.image
                          });
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 20.w),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: theme
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.blue.shade800,
                                  ),
                                  assets.iconBurger.image(
                                    height: 30,
                                    width: 30,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${notificationItem?.title}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                        '${notificationItem?.description}9999999999999999999999999',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          height: 0,
                        ),
                      ],
                    ),
                  ),
                );
              })),
            ),
          ),
        ],
      ),
    );
  }
}
