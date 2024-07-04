import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_state.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_detail_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).orderlist();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
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
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder:
                          //         (context, animation, secondaryAnimation) =>
                          //             const HomePage(),
                          //     transitionsBuilder: (context, animation,
                          //         secondaryAnimation, child) {
                          //       return child;
                          //     },
                          //   ),
                          // );
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)?.order_header ?? 'My Order',
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
          child: order.status == OrderStatus.loading
              ? Center(child: CircularProgressIndicator())
              : order.error != null
                  ? Center(child: Text("Error: ${order.error}"))
                  : order.status == OrderStatus.empty
                      ? Center(
                          child: Text(
                          AppLocalizations.of(context)?.order_empty ??
                              'No History Order',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                  children: List.generate(
                                      order.orderList?.length ?? 0, (i) {
                                final orderItem = order.orderList?[i];

                                DateTime dateTime =
                                    DateTime.parse(orderItem?.orderDate ?? '');

                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(dateTime);

                                String formattedTime =
                                    DateFormat('h:mm a').format(dateTime);

                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  OrderDetailPage(
                                                      id: orderItem?.id ?? 0,
                                                      address:
                                                          orderItem?.address ??
                                                              '',
                                                      tel: orderItem?.tel ?? '',
                                                      date: formattedDate,
                                                      time: formattedTime)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.h, horizontal: 20.w),
                                      child: Row(
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("ID: ${orderItem?.id}"),
                                                Text(
                                                    'Date: $formattedDate $formattedTime')
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
        ),
      ],
    ));
  }
}
