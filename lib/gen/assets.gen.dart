/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bacon_burger.jpg
  AssetGenImage get baconBurger =>
      const AssetGenImage('assets/images/bacon_burger.jpg');

  /// File path: assets/images/banana_bread.jpg
  AssetGenImage get bananaBread =>
      const AssetGenImage('assets/images/banana_bread.jpg');

  /// File path: assets/images/ceasar_salad.png
  AssetGenImage get ceasarSalad =>
      const AssetGenImage('assets/images/ceasar_salad.png');

  /// File path: assets/images/cheese_burger.jpg
  AssetGenImage get cheeseBurger =>
      const AssetGenImage('assets/images/cheese_burger.jpg');

  /// File path: assets/images/custard_bread.jpg
  AssetGenImage get custardBread =>
      const AssetGenImage('assets/images/custard_bread.jpg');

  /// File path: assets/images/fried_chicken.jpg
  AssetGenImage get friedChicken =>
      const AssetGenImage('assets/images/fried_chicken.jpg');

  /// File path: assets/images/hawaiian_pizza.jpg
  AssetGenImage get hawaiianPizza =>
      const AssetGenImage('assets/images/hawaiian_pizza.jpg');

  /// File path: assets/images/icon_bread.png
  AssetGenImage get iconBread =>
      const AssetGenImage('assets/images/icon_bread.png');

  /// File path: assets/images/icon_bread_active.png
  AssetGenImage get iconBreadActive =>
      const AssetGenImage('assets/images/icon_bread_active.png');

  /// File path: assets/images/icon_bread_active_dark.png
  AssetGenImage get iconBreadActiveDark =>
      const AssetGenImage('assets/images/icon_bread_active_dark.png');

  /// File path: assets/images/icon_burger.png
  AssetGenImage get iconBurger =>
      const AssetGenImage('assets/images/icon_burger.png');

  /// File path: assets/images/icon_burger_active.png
  AssetGenImage get iconBurgerActive =>
      const AssetGenImage('assets/images/icon_burger_active.png');

  /// File path: assets/images/icon_burger_active_dark.png
  AssetGenImage get iconBurgerActiveDark =>
      const AssetGenImage('assets/images/icon_burger_active_dark.png');

  /// File path: assets/images/icon_fried_chicken.png
  AssetGenImage get iconFriedChicken =>
      const AssetGenImage('assets/images/icon_fried_chicken.png');

  /// File path: assets/images/icon_fried_chicken_active.png
  AssetGenImage get iconFriedChickenActive =>
      const AssetGenImage('assets/images/icon_fried_chicken_active.png');

  /// File path: assets/images/icon_fried_chicken_active_dark.png
  AssetGenImage get iconFriedChickenActiveDark =>
      const AssetGenImage('assets/images/icon_fried_chicken_active_dark.png');

  /// File path: assets/images/icon_pizza.png
  AssetGenImage get iconPizza =>
      const AssetGenImage('assets/images/icon_pizza.png');

  /// File path: assets/images/icon_pizza_active.png
  AssetGenImage get iconPizzaActive =>
      const AssetGenImage('assets/images/icon_pizza_active.png');

  /// File path: assets/images/icon_pizza_active_dark.png
  AssetGenImage get iconPizzaActiveDark =>
      const AssetGenImage('assets/images/icon_pizza_active_dark.png');

  /// File path: assets/images/icon_salad.png
  AssetGenImage get iconSalad =>
      const AssetGenImage('assets/images/icon_salad.png');

  /// File path: assets/images/icon_salad_active.png
  AssetGenImage get iconSaladActive =>
      const AssetGenImage('assets/images/icon_salad_active.png');

  /// File path: assets/images/icon_salad_active_dark.png
  AssetGenImage get iconSaladActiveDark =>
      const AssetGenImage('assets/images/icon_salad_active_dark.png');

  /// File path: assets/images/korean_fried_chicken.jpg
  AssetGenImage get koreanFriedChicken =>
      const AssetGenImage('assets/images/korean_fried_chicken.jpg');

  /// File path: assets/images/pepperoni_pizza.jpg
  AssetGenImage get pepperoniPizza =>
      const AssetGenImage('assets/images/pepperoni_pizza.jpg');

  /// File path: assets/images/vegan_salad.jpg
  AssetGenImage get veganSalad =>
      const AssetGenImage('assets/images/vegan_salad.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        baconBurger,
        bananaBread,
        ceasarSalad,
        cheeseBurger,
        custardBread,
        friedChicken,
        hawaiianPizza,
        iconBread,
        iconBreadActive,
        iconBreadActiveDark,
        iconBurger,
        iconBurgerActive,
        iconBurgerActiveDark,
        iconFriedChicken,
        iconFriedChickenActive,
        iconFriedChickenActiveDark,
        iconPizza,
        iconPizzaActive,
        iconPizzaActiveDark,
        iconSalad,
        iconSaladActive,
        iconSaladActiveDark,
        koreanFriedChicken,
        pepperoniPizza,
        veganSalad
      ];
}


class Assets {
  Assets._();

  static const String food = 'assets/food.json';
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// List of all assets
  static List<String> get values => [food];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
