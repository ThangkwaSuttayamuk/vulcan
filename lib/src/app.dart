import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/core/theme/dark_theme.dart';
import 'package:flutter_application_1/src/core/theme/light_theme.dart';
import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/notification/notification_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/cart_page.dart';
import 'package:flutter_application_1/src/presentation/pages/credit_card_page.dart';
import 'package:flutter_application_1/src/presentation/pages/favorite_page.dart';
import 'package:flutter_application_1/src/presentation/pages/image_page.dart';
import 'package:flutter_application_1/src/presentation/pages/language_page.dart';
import 'package:flutter_application_1/src/presentation/pages/loading_page.dart';
import 'package:flutter_application_1/src/presentation/pages/login_page.dart';
import 'package:flutter_application_1/src/presentation/pages/message_page.dart';
import 'package:flutter_application_1/src/presentation/pages/notification_detail_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_page.dart';
import 'package:flutter_application_1/src/presentation/pages/search_page.dart';
import 'package:flutter_application_1/src/presentation/pages/setting_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/pages/theme_page.dart';
import 'package:flutter_application_1/src/presentation/transition/fade.dart';
import 'package:flutter_application_1/src/presentation/transition/slide_enter_right_to_left.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class FoodApp extends ConsumerStatefulWidget {
  const FoodApp({super.key});

  @override
  _FoodAppState createState() => _FoodAppState();
}

class _FoodAppState extends ConsumerState<FoodApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();

    // Get Firebase Token
    _firebaseMessaging.getToken().then((token) {
      print('Firebase Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ref.read(notificationProvider.notifier).addNotification(
          message.data['title'],
          message.data['period'],
          message.data['description'],
          message.data['image']);
      print("Recieved Message: ${message.data['period']}");
    });


  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final language = ref.watch(languageProvider).saveLanguage;
    final theme = ref.watch(themeProvider).theme;

    return ScreenUtilInit(
        designSize: const Size(390, 850),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            initialRoute: '/loading',
            navigatorKey: navigatorKey,
            routes: {
              "/": (context) => const LoginPage(),
              "/home": (context) => const HomePage(),
              "/cart": (context) => const CartPage(),
              "/favorite": (context) => const FavoritePage(),
              "/language": (context) => const LanguagePage(),
              "/loading": (context) => const LoadingPage(),
              "/order": (context) => const OrderPage(),
              "/search": (context) => const SearchPage(),
              "/setting": (context) => const SettingPage(),
              "/theme": (context) => const ThemePage(),
              "/credit card": (context) => const CreditCardPage(),
            },
            onGenerateRoute: (settings) {
              Object? args = settings.arguments;
              switch (settings.name) {
                case '/detail':
                  return SlideEnterRightToLeft(
                    child: DetailPage(args),
                  );
                case '/message':
                  return SlideEnterRightToLeft(
                    child: MessagePage(args),
                  );
                case '/image':
                  return Fade(
                    child: ImagePage(args),
                  );
                case '/notification_detail':
                  return SlideEnterRightToLeft(
                    child: NotificationDetailPage(args),
                  );
                default:
                  return PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomePage());
              }
            },
            title: "FoodApp",
            themeMode: theme ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            locale: Locale(language ?? 'en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
