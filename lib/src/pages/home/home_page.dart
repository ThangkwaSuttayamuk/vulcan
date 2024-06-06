import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/cart/cart.dart';
import 'package:flutter_application_1/src/pages/detail/food_detail.dart';

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
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const CartPage()));
                                },
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Color.fromARGB(190, 13, 72, 161),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  //
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(190, 13, 72, 161),
                                ),
                              ),
                            )
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
                            return Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Color.fromARGB(190, 13, 72, 161),
                                    width: _checkFilter ? 2 : 0,
                                  )),
                              color: _checkFilter
                                  ? Colors.white
                                  : Color.fromARGB(190, 13, 72, 161),
                              // borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  _checkFilter = !_checkFilter;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/images/icon_${_checkFilter ? _filter[i] + "_active" : _filter[i]}.png',
                                    height: 40,
                                  ),
                                ),
                              ),
                            );
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
              )
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      //
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                            Text("favorite")
                          ],
                        )),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.black,
                            ),
                            Text("home")
                          ],
                        )),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            Text("setting")
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
