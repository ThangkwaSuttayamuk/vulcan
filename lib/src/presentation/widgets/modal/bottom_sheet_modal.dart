import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetModal extends ConsumerWidget {
  const BottomSheetModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartlistState = ref.watch(cartProvider);

    return Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text(
                      AppLocalizations.of(context)?.cart_adrdess ??
                          'Delivery Address:',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 3,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    ref.read(cartProvider.notifier).setAddress(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Example:\n1234 Main Street, Lincoln, NE 68509',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    Text(
                      AppLocalizations.of(context)?.cart_phone_number ??
                          'Phone Number:',
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 1,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    ref.read(cartProvider.notifier).setTel(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: '089XXXXXXX',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    Text(
                      AppLocalizations.of(context)?.cart_summary ??
                          'Order Summary:',
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    children:
                        List.generate(cartlistState.cartList?.length ?? 0, (i) {
                  final cartItem = cartlistState.cartList?[i];
                  return Column(
                    children: [
                      foodCard(cartItem?.name ?? '', cartItem?.image ?? '',
                          cartItem?.price ?? 0.0, cartItem?.quantity ?? 0),
                      divider(i, cartlistState.cartList?.length ?? 0)
                    ],
                  );
                })),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.cart_total ?? 'Total',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$${ref.read(cartProvider.notifier).getTotal()}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                      child: MaterialButton(
                          enableFeedback: false,
                          child: Text(
                            AppLocalizations.of(context)?.cart_order ?? 'Order',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          height: 40,
                          color: Colors.blue.shade800,
                          disabledColor: Colors.grey.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            if (ref
                                    .read(cartProvider.notifier)
                                    .getAddress()
                                    .isEmpty ||
                                ref
                                    .read(cartProvider.notifier)
                                    .getTel()
                                    .isEmpty) {
                            } else {
                              ref.read(orderProvider.notifier).addOrder(
                                  ref.read(cartProvider.notifier).getAddress(),
                                  ref.read(cartProvider.notifier).getTel());

                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/order',
                                  ModalRoute.withName('/loading'));
                            }
                          }))
                ]),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget foodCard(String name, String image, double price, int quantity) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("${quantity}x"),
              const SizedBox(
                width: 20,
              ),
              Text(name),
            ],
          ),
          Text("${quantity * price}")
        ],
      ),
    );
  }

  Widget divider(int index, int length) {
    return index == length - 1
        ? const SizedBox()
        : Divider(
            color: Colors.grey.shade400,
            height: 0,
          );
  }
}
