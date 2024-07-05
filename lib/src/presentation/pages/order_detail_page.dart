import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  final int id;
  final String address;
  final String tel;
  final String date;
  final String time;
  const OrderDetailPage(
      {super.key,
      required this.id,
      required this.address,
      required this.tel,
      required this.date,
      required this.time});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).getOrderListById(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider).orderItems;
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
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "ID: ${widget.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${widget.date} ${widget.time}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
            child: Material(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              Text(widget.address),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Text(widget.tel),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text("Order Summary"),
                    Column(
                        children: List.generate(order?.length ?? 0, (i) {
                      final orderItem = order?[i];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "x${orderItem?.quantity.toString() ?? ''}"),
                                    const SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(orderItem?.name ?? ''),
                                      Text(
                                          "\$${orderItem!.price * orderItem.quantity.toDouble()}")
                                    ],
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
                      );
                    })),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total'),
                          Text(
                              '\$${ref.read(orderProvider.notifier).getTotal()}')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
