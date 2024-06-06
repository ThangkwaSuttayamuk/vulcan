import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/cart/cart.dart';
import 'package:flutter_application_1/src/pages/detail/food_detail.dart';
import 'package:flutter_application_1/src/widgets/button/filter_button.dart';
import 'package:flutter_application_1/src/widgets/button/regular_icon_button.dart';
import 'package:flutter_application_1/src/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/widgets/footer/footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final List<String> _filter = [
    "hamburger",
    "pizza",
    "bread",
    "salad",
    "fried_chicken"
  ];

  bool _checkFilter = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = "";
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search...",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          _filter.length,
                          (i) {
                            return FilterButton(filter: _filter, index: i);
                          },
                        )),
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
                child: GridView.builder(
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 40,
                      childAspectRatio: 9 / 10),
                  itemCount: 5,
                  itemBuilder: (context, int i) {
                    return FoodCard();
                  },
                ),
              )
            ],
          ),
        ),
        Footer()
      ],
    );
  }
}
