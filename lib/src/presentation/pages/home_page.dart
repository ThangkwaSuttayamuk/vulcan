import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer.dart';
import 'package:flutter_application_1/utils/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // final GetAllFood getAllFood = GetAllFood(FoodRepositoryImpl());
  // final DatabaseService _databaseService = DatabaseService.instance;
  final DatabaseHelper dbHelper = DatabaseHelper();

  // List<Food> _foodItems = [];

  final _searchController = TextEditingController();

  final List<String> _filter = [
    "burger",
    "pizza",
    "bread",
    "salad",
    "fried_chicken"
  ];

  bool _checkFilter = false;

  @override
  void initState() {
    super.initState();
    // loadFoodItems();
    importData();
    _searchController.text = "";
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(textProvider.notifier).initData();
    // });
    // ref.read(foodListProvider.notifier).fetchFoods();
  }

  // Future<void> loadFoodItems() async {
  //   final jsonString = await rootBundle.loadString('assets/food.json');
  //   // final List<dynamic> jsonResponse = json.decode(jsonString);
  //   List<dynamic> response = json.decode(jsonString);
  //   print(response);
  //   // print("1 ${jsonResponse}");

  //   _foodItems = response.map<Food>((json) => Food.fromJson(json)).toList();

  //   setState(() {});
  // }

  Future<void> importData() async {
    String jsonString = await rootBundle.loadString('assets/food.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    List<Food> foodList = jsonData.map((item) {
      return Food.fromJson(item);
    }).toList();

    await dbHelper.insertMultipleFoods(foodList);

    ref.read(foodListProvider.notifier).fetchFoods();

    setState(() {}); // Refresh the UI after inserting data
  }

  @override
  Widget build(BuildContext context) {
    final foodListState = ref.watch(foodListProvider);
    
    // final searchState = ref.watch(searchProvider);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cashier',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
                        Row(
                          children: [
                            RegularIconButton(name: "cart"),
                            SizedBox(
                              width: 5,
                            ),
                            RegularIconButton(name: "favorite"),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: 50,
                        child: Consumer(builder: (BuildContext context,
                            WidgetRef ref, Widget? child) {
                          return TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                ref
                                    .read(foodListProvider.notifier)
                                    .filterFoods(value);
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "Search...",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          _filter.length,
                          (index) {
                            return FilterButton(filters: _filter, index: index);
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Center(
                    //     child: Text(
                    //         'Current Filter: ${filterState.filterName ?? 'None'}'),
                    //   ),
                    // ),
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: List.generate(
                    //       _filter.length,
                    //       (i) {
                    //         return FilterButton(
                    //           filter: _filter,
                    //           index: i,
                    //           onTap: () {
                    //             print("Tapped on ${_filter[i]}");
                    //             ref
                    //                 .read(foodListProvider.notifier)
                    //                 .filterFoodsByCategory(_filter[i]);
                    //           },
                    //         );
                    //         // GestureDetector(
                    //         //   onTap: () {
                    //         //     print(
                    //         //         "Tapped on ${_filter[i]}"); // Print to verify onTap is triggered
                    //         //   },
                    //         //   child: Text(_filter[
                    //         //       i]), // Display category name directly
                    //         // ),

                    //         // GestureDetector(
                    //         //     onTap: () {
                    //         //       // print(_filter[i]);
                    //         //       print(_filter[
                    //         //           i]); // Print the category to verify onTap is triggered
                    //         //       ref
                    //         //           .read(foodListProvider.notifier)
                    //         //           .filterFoodsByCategory(_filter[i]);
                    //         //     },
                    //         //     child: FilterButton(filter: _filter, index: i));
                    //       },
                    //     )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      child: Row(
                        children: [
                          Text(
                            "Menu",
                            style: TextStyle(
                                color: Color.fromARGB(190, 13, 72, 161),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: foodListState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : foodListState.error != null
                        ? Center(child: Text('Error: ${foodListState.error}'))
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
                            itemCount: foodListState.foods.length,
                            itemBuilder: (context, index) {
                              final foodItem = foodListState.foods[index];
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
                          ),
              ),
              // FutureBuilder<List<Food>>(
              //   future: dbHelper.getFoods(),
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
              //             gridDelegate:
              //                 SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2,
              //               crossAxisSpacing: 20,
              //               mainAxisSpacing: 40,
              //               childAspectRatio:
              //                   (MediaQuery.of(context).size.width /
              //                           MediaQuery.of(context).size.height) /
              //                       0.5,
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
              //                                 // id: foodItem.id,
              //                                 // name: foodItem.name,
              //                                 // description: foodItem.description,
              //                                 // price: foodItem.price,
              //                                 // image: foodItem.image,
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

              // FutureBuilder<List<Food>>(
              //   future: getAllFood(),
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
              //             gridDelegate:
              //                 SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2,
              //               crossAxisSpacing: 20,
              //               mainAxisSpacing: 40,
              //               childAspectRatio:
              //                   (MediaQuery.of(context).size.width /
              //                           MediaQuery.of(context).size.height) /
              //                       0.5,
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
              //                   name: foodItem.name,
              //                   description: foodItem.description,
              //                   image: foodItem.image,
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
              //   child: GridView.builder(
              //     padding:
              //         const EdgeInsets.only(bottom: 100, left: 20, right: 20),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 20,
              //         mainAxisSpacing: 40,
              //         childAspectRatio: 9 / 10),
              //     itemCount: 5,
              //     itemBuilder: (context, int i) {
              //       return FoodCard();
              //     },
              //   ),
              // ),

              // Expanded(
              //   child: GridView.builder(
              //     padding:
              //         const EdgeInsets.only(bottom: 100, left: 20, right: 20),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 20,
              //         mainAxisSpacing: 40,
              //         childAspectRatio: 9 / 10),
              //     itemCount: _foodItems.length,
              //     itemBuilder: (context, index) {
              //       return FoodCard(
              //         food: _foodItems[index],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        Footer()
      ],
    );
  }
}
