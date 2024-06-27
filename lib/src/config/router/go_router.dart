import 'package:flutter_application_1/src/presentation/pages/cart_page.dart';
import 'package:flutter_application_1/src/presentation/pages/favorite_page.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/language_page.dart';
import 'package:flutter_application_1/src/presentation/pages/login_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_detail_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_page.dart';
import 'package:flutter_application_1/src/presentation/pages/search_page.dart';
import 'package:flutter_application_1/src/presentation/pages/setting_page.dart';
import 'package:flutter_application_1/src/presentation/pages/theme_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: "home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
            path: "search",
            builder: (context, state) => const SearchPage(),
            routes: [detail]),
        GoRoute(
            path: "setting",
            builder: (context, state) => const SettingPage(),
            routes: [
              GoRoute(
                path: "language",
                builder: (context, state) => const LanguagePage(),
              ),
              GoRoute(
                path: "theme",
                builder: (context, state) => const ThemePage(),
              ),
            ]),
        GoRoute(
            path: "order",
            builder: (context, state) => const OrderPage(),
            routes: [
              GoRoute(
                  path: 'orderdetail',
                  builder: (context, state) {
                    Map<String, dynamic> args =
                        state.extra as Map<String, dynamic>;
                    return OrderDetailPage(
                        id: args['id'] ?? 0,
                        address: args['address'] ?? '',
                        tel: args['tel'] ?? '',
                        date: args['date'] ?? '',
                        time: args['time'] ?? '');
                  })
            ]),
        GoRoute(
            path: "favorite",
            builder: (context, state) => const FavoritePage(),
            routes: [detail]),
        GoRoute(
            path: "cart",
            builder: (context, state) => const CartPage(),
            routes: [detail]),
        detail
      ],
    ),
  ],
);

final GoRoute detail = GoRoute(
    path: 'detail',
    builder: (context, state) {
      Map<String, dynamic> args = state.extra as Map<String, dynamic>;
      return FoodDetail(
        id: args['id'] ?? 0,
      );
    });
