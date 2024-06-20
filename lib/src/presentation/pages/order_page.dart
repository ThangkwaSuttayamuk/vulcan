import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_state.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HomePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child;
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)?.language_header ??
                      'Choose Language',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: order.status == OrderStatus.loading
              ? Center(child: CircularProgressIndicator())
              : order.error != null
                  ? Center(child: Text("Error: ${order.error}"))
                  : order.status == OrderStatus.empty
                      ? Center(
                          child: Text(
                          AppLocalizations.of(context)?.cart_empty ??
                              'Empty Cart',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                  children: List.generate(
                                      order.orderList?.length ?? 0, (i) {
                                final orderItem = order.orderList?[i];

                                return Text(orderItem?.tel ?? '');
                              })),
                              SizedBox(
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
