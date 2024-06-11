import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/food_detail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _CartPageState();
}

class _CartPageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Likes',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          children: [Expanded(
                child: GridView.builder(
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 40,
                      childAspectRatio: 9 / 10),
                  itemCount: 7,
                  itemBuilder: (context, int i) {
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const FoodDetail()));
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
                                        image: AssetImage(
                                            'assets/images/fried_chicken.jpg'))),
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
                  },
                ),
              )],
        ));
  }
}
