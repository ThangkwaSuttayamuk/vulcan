import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartButton extends ConsumerWidget {
  final int id;
  final double price;
  const AddToCartButton({super.key, required this.id, required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider.notifier);

    final food = ref.watch(foodListProvider);

    if (food.status != HomeStatus.success) {
      return SizedBox(
        height: 40.h,
        width: 200.h,
        child: const ShimmerBox(),
      );
    }

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue.shade800,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ref.read(cartProvider.notifier).addToCart(id, ref.watch(quantityProvider).quantity);
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Text(
            'Add to Cart - \$$price',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
