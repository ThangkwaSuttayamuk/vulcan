import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/footer/footer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _searchController = TextEditingController();

  final List<String> _filter = [
    "burger",
    "pizza",
    "bread",
    "salad",
    "fried_chicken"
  ];

  @override
  void initState() {
    _searchController.text = "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodListProvider.notifier).fetchFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodListState = ref.watch(foodListProvider);

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
                                                id: foodItem.id,
                                                name: foodItem.name,
                                                description:
                                                    foodItem.description,
                                                price: foodItem.price,
                                                image: foodItem.image,
                                              )));
                                },
                                child: FoodCard(
                                  food: foodItem,
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
        Footer()
      ],
    );
  }
}
