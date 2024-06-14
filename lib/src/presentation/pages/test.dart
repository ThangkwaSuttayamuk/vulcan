import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/src/domain/entities/food_entity.dart';
import 'package:flutter_application_1/src/presentation/bloc/food_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Items'),
      ),
      body: BlocBuilder<FoodBloc, List<FoodEntity>>(
        builder: (context, foodList) {
          return ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final food = foodList[index];
              return ListTile(
                leading: Image.network(food.image),
                title: Text(food.name),
                subtitle: Text(food.description),
                trailing: Text('\$${food.price.toStringAsFixed(2)}'),
                onTap: () {
                  // Handle tap on food item
                },
              );
            },
          );
        },
      ),
    );
  }
}
