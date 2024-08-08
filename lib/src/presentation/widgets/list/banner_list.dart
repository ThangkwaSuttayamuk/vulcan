import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class BannerList extends StatefulWidget {
  const BannerList({super.key});

  @override
  State<BannerList> createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  final PageController _controller = PageController(initialPage: 10000);
  List<String> image = [];
  int _index = 0;
  Timer? _timer;
  final _remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    _initRemoteConfig();

    _startAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_controller.hasClients) {
        _controller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  _initRemoteConfig() async {
    //Default Setting
    await _remoteConfig.setDefaults({'name': "name", "image": []});

    //Configuration
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 10)));

    await _remoteConfig.fetchAndActivate();

    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
    });

    image = _remoteConfig.getString('image').split(',') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    print(_remoteConfig.getString('image'));
    image = _remoteConfig.getString('image').split(',') ?? [];
    return SizedBox(
        height: 200, // Card height
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _index = index % 4; // Assuming 10 items
            });
          },
          itemBuilder: (context, index) {
            final itemIndex = index % 4; // Assuming 10 items
            final imageUrl = image[itemIndex];
            return AnimatedPadding(
              duration: const Duration(milliseconds: 400),
              // curve: Curves.fastOutSlowIn,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                  elevation: 4,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/images/default.png',
                        fit: BoxFit.fill,
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      );
                    },
                  )

                  // Image.network(
                  //   image[itemIndex],
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            );
          },
        ));
  }
}
