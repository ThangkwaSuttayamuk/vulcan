import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/add_to_cart_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/favorite_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/text_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailPage extends ConsumerStatefulWidget {
  final id;

  const DetailPage(
    this.id, {
    super.key,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late ScrollController _scrollController;
  late double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quantityProvider.notifier).initData();
      ref.read(cartProvider.notifier);
      ref.read(foodListProvider.notifier).getFoodById(widget.id);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quantityState = ref.watch(quantityProvider);
    final quantityControllerState = ref.read(quantityProvider.notifier);
    final food = ref.watch(foodListProvider);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(controller: _scrollController, slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              leadingWidth: 50.w,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _scrollPosition >= 100.h
                            ? Colors.transparent
                            : Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              expandedHeight: 170.h,
              elevation: 0,
              pinned: true,
              stretch: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Hero(
                      tag: 'tag-1',
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/image',
                                arguments: food.foodById?.image);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/${food.foodById?.image}'))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: FavoriteButton(foodId: widget.id)),
                  ],
                ),
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground
                ],
              ),
              title: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: AnimatedOpacity(
                    opacity: _scrollPosition >= 150.h ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Text(food.foodById?.name ?? ''),
                  )),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          food.foodById?.name ?? '',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            food.foodById?.description ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)?.detail_ingredient ??
                              'Ingredints:',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextCard(
                    listOfItem: food.foodById?.ingredients.split(',') ?? [],
                  ),
                  const SizedBox(
                    height: 500,
                  )
                ],
              ),
            )),
          ]),
          Container(
            alignment: Alignment.topCenter,
            height: 100,
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            quantityControllerState.decrease();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: Colors.grey.shade800)),
                            child: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 50,
                          child: Material(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              quantityState.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            quantityControllerState.increase();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: Colors.grey.shade800)),
                            child: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AddToCartButton(
                      id: widget.id, price: food.foodById?.price ?? 0.0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
