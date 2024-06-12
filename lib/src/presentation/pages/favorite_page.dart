import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteFoodProvider.notifier).fetchFavoriteFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritelistState = ref.watch(favoriteFoodProvider);

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
          children: [
            Expanded(
                child: favoritelistState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : favoritelistState.error != null
                        ? Center(
                            child: Text('Error: ${favoritelistState.error}'))
                        : GridView.builder(
                            padding: const EdgeInsets.only(
                                bottom: 100, left: 20, right: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 40,
                              childAspectRatio:
                                  (MediaQuery.of(context).size.width /
                                          MediaQuery.of(context).size.height) /
                                      0.5,
                            ),
                            itemCount: favoritelistState.favoriteFoods.length,
                            itemBuilder: (context, index) {
                              final foodItem =
                                  favoritelistState.favoriteFoods[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              FoodDetail(
                                                foodItem: foodItem,
                                              )));
                                },
                                child: FoodCard(
                                  food: foodItem,
                                ),
                              );
                            },
                          ))
            // FutureBuilder<List<Food>>(
            //   future: dbHelper.getAllFavorites(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Center(child: Text('No data found'));
            //     } else {
            //       return Expanded(
            //         child: SizedBox(
            //           height: MediaQuery.of(context).size.height,
            //           width: MediaQuery.of(context).size.width,
            //           child: GridView.builder(
            //             padding: const EdgeInsets.only(
            //                 bottom: 100, left: 20, right: 20),
            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               crossAxisSpacing: 20,
            //               mainAxisSpacing: 40,
            //               childAspectRatio: (MediaQuery.of(context).size.width /
            //                       MediaQuery.of(context).size.height) /
            //                   0.5,
            //             ),
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               final foodItem = snapshot.data![index];
            //               return GestureDetector(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute<void>(
            //                           builder: (BuildContext context) =>
            //                               FoodDetail(
            //                                 foodItem: foodItem,
            //                               )));
            //                 },
            //                 child: FoodCard(
            //                   food: foodItem,
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ),
            // Expanded(
            //     child: GridView.builder(
            //       padding:
            //           const EdgeInsets.only(bottom: 100, left: 20, right: 20),
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           crossAxisSpacing: 20,
            //           mainAxisSpacing: 40,
            //           childAspectRatio: 9 / 10),
            //       itemCount: 7,
            //       itemBuilder: (context, int i) {
            //         return Container(
            //           decoration: BoxDecoration(boxShadow: [
            //             BoxShadow(
            //               color: Colors.grey,
            //               spreadRadius: -6,
            //               blurRadius: 7,
            //               offset: Offset(0, 10),
            //             )
            //           ]),
            //           child: Material(
            //             color: Colors.white,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             child: InkWell(
            //               borderRadius: BorderRadius.circular(10),
            //               onTap: () {
            //                 // Navigator.push(
            //                 //     context,
            //                 //     MaterialPageRoute<void>(
            //                 //         builder: (BuildContext context) =>
            //                 //             const FoodDetail()));
            //               },
            //               child: Column(
            //                 children: [
            //                   Container(
            //                     height: 120,
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.only(
            //                             topLeft: Radius.circular(10),
            //                             topRight: Radius.circular(10)),
            //                         image: DecorationImage(
            //                             fit: BoxFit.cover,
            //                             image: AssetImage(
            //                                 'assets/images/fried_chicken.jpg'))),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(10),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           'foodnamedkpokpoaknkjnnljk;lk;lwoa',
            //                           maxLines: 1,
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                         Text('food price'),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   )
          ],
        ));
  }
}
