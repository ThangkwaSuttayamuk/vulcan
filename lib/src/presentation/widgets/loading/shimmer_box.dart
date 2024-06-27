import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.secondary,
      highlightColor: Theme.of(context).cardColor,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class ShimmerView extends StatelessWidget {
  final int length;
  const ShimmerView({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 20.h,
        mainAxisSpacing: 40.w,
        maxCrossAxisExtent: 180.w,
      ),
      itemCount: length,
      itemBuilder: (context, index) {
        return const ShimmerBox();
      },
    );
  }
}

class DetailLoading extends StatelessWidget {
  const DetailLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(height: 250, child: ShimmerBox()),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(height: 30, width: 250, child: ShimmerBox()),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(height: 30, child: ShimmerBox()),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(height: 30, width: 130, child: ShimmerBox()),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(height: 30, width: 80, child: ShimmerBox()),
            SizedBox(
              width: 10,
            ),
            SizedBox(height: 30, width: 80, child: ShimmerBox()),
            SizedBox(
              width: 10,
            ),
            SizedBox(height: 30, width: 80, child: ShimmerBox()),
          ],
        ),
      ],
    );
  }
}

class CartLoading extends StatelessWidget {
  const CartLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(height: 200, child: ShimmerBox()),
        SizedBox(
          height: 20,
        ),
        SizedBox(height: 200, child: ShimmerBox()),
      ],
    );
  }
}

class Loading {
  const Loading();

  Column get cart => const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 200, child: ShimmerBox()),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 200, child: ShimmerBox()),
        ],
      );

  Column get detail => const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 250, child: ShimmerBox()),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(height: 30, width: 250, child: ShimmerBox()),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(height: 30, child: ShimmerBox()),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(height: 30, width: 130, child: ShimmerBox()),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(height: 30, width: 80, child: ShimmerBox()),
              SizedBox(
                width: 10,
              ),
              SizedBox(height: 30, width: 80, child: ShimmerBox()),
              SizedBox(
                width: 10,
              ),
              SizedBox(height: 30, width: 80, child: ShimmerBox()),
            ],
          ),
        ],
      );

  Widget get food => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 20.h,
          mainAxisSpacing: 40.w,
          maxCrossAxisExtent: 180.w,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return const ShimmerBox();
        },
      );
}
