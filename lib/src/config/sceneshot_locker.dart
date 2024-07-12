import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ScreenshotLocker {
  static const _channel = MethodChannel('exampleChannel/screenshot-locker');

  Future<void> enableScreenshots() async {
    if (Platform.isIOS) {
      await _channel.invokeMethod('enablescreen');
    } else {

      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }

  Future<void> disableScreenshots() async {
    if (Platform.isIOS) {
      await _channel.invokeMethod('disablescreen');
    } else {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }
}
