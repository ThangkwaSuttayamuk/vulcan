import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: -6,
          blurRadius: 7,
          offset: Offset(0, 10),
        )
      ]),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const FoodDetail()));
          },
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/fried_chicken.jpg'))),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'foodnamedkpokpoaknkjnnljk;lk;lwoa',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('food price'),
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
