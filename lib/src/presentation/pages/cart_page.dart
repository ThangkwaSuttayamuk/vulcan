import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card_add_remove.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/cart_list.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_application_1/src/presentation/widgets/modal/bottom_sheet_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(cartProvider.notifier).cartFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartStatus = ref.watch(cartProvider.select((value) => value.status));
    final cartList = ref.watch(cartProvider.select((value) => value.cartList));
    final cartError = ref.watch(cartProvider.select((value) => value.error));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text(
              '${AppLocalizations.of(context)?.cart_header ?? 'Cart'} (${cartList?.length})',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: cartStatus == CartStatus.loading
                    ? Center(child: loading())
                    : cartError != null
                        ? Center(child: Text("Error: $cartError"))
                        : cartStatus == CartStatus.empty
                            ? Center(
                                child: Text(
                                AppLocalizations.of(context)?.cart_empty ??
                                    'Empty Cart',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ))
                            : const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CartList(),
                                    SizedBox(
                                      height: 130,
                                    )
                                  ],
                                ),
                              ),
              ),
            ],
          )),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 130,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          AppLocalizations.of(context)?.cart_total ?? 'Total',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          '\$${ref.read(cartProvider.notifier).getTotal()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                cartStatus == CartStatus.loading
                    ? const SizedBox(
                        height: 40,
                        child: ShimmerBox(),
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: MaterialButton(
                                  enableFeedback: false,
                                  child: Text(
                                    AppLocalizations.of(context)?.cart_order ??
                                        'Order',
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
                                  onPressed: cartStatus == CartStatus.empty
                                      ? null
                                      : () {
                                          final cartState =
                                              ref.read(cartProvider.notifier);
                                          cartState.initData();
                                          showModal();
                                        }))
                        ],
                      ),
              ],
            ),
          ),
        )
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

  Future showModal() {
    return showModalBottomSheet<void>(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return const BottomSheetModal();
        });
  }

  Widget loading() {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(height: 120, child: ShimmerBox()),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(height: 120, child: ShimmerBox()),
        ),
      ],
    );
  }
}
