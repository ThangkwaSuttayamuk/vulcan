import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCard extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final double price;
  final String ingredients;
  final String image;

  const FoodCard({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.ingredients,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).cardTheme.shadowColor!,
          spreadRadius: -6,
          blurRadius: 7,
          offset: const Offset(0, 10),
        )
      ]),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: id);
          },
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/$image'))),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color:
                              Theme.of(context).textTheme.titleMedium?.color),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       '\$${price}',
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //       style: TextStyle(
                    //           fontSize: 14.sp, fontWeight: FontWeight.w700),
                    //     ),
                    //     Material(
                    //         borderRadius: BorderRadius.circular(20),
                    //         child: InkWell(
                    //           borderRadius: BorderRadius.circular(20),
                    //           onTap: () {
                    //             print('add to cart');
                    //           },
                    //           child: Stack(
                    //             alignment: Alignment.center,
                    //             children: [
                    //               CircleAvatar(
                    //                 backgroundColor: Theme.of(context)
                    //                     .textTheme
                    //                     .titleLarge
                    //                     ?.color,
                    //                 radius: 10.h,
                    //               ),
                    //               Icon(
                    //                 Icons.add,
                    //                 color:
                    //                     Theme.of(context).colorScheme.secondary,
                    //                 size: 20,
                    //               ),
                    //             ],
                    //           ),
                    //         ))
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
