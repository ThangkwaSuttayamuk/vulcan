import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateCartButton extends ConsumerWidget {
  final int id;
  const UpdateCartButton({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodStatus =
        ref.watch(foodListProvider.select((value) => value.status));
    final quantity =
        ref.watch(quantityProvider.select((value) => value.quantity));

    if (foodStatus != HomeStatus.success) {
      return SizedBox(
        height: 40.h,
        width: 200.h,
        child: const ShimmerBox(),
      );
    }

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: quantity == 0 ? Colors.red : Colors.blue.shade800,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          quantity == 0
              ? ref.read(cartProvider.notifier).deleteFormCart(id)
              : ref
                  .read(cartProvider.notifier)
                  .updateQuantityCart(id, quantity);

          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Text(
            quantity == 0
                ? AppLocalizations.of(context)?.detail_delete_form_cart ??
                    'Delete Form Cart'
                : AppLocalizations.of(context)?.detail_update_cart ??
                    'Update Cart',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
