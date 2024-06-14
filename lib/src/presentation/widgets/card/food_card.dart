import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';

class FoodCard extends StatelessWidget {
  final FoodEntity food;

  const FoodCard({super.key, required this.food});

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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodDetail(
                          id: food.id,
                          name: food.name,
                          description: food.description,
                          price: food.price,
                          image: food.image,
                        )));
          },
          borderRadius: BorderRadius.circular(10),
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
                        image: AssetImage('assets/images/${food.image}'))),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      food.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
