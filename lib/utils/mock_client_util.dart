import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import '../constants/stub_constants.dart';

class MockClientUtils {
  MockClient integrationTestMockClient = MockClient((request) async {
    debugPrint("MockClientUtils :$request");
    final header = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};
    final foodRes = await rootBundle.loadString('assets/stub/food.json');


    switch (request.url.toString()) {
      case StubConstants.food:
        return Response(foodRes, 200, headers: header);
      default:
        return Response("", 404);
    }
  });

  Future<Response> mock(String path) async {
    final data = integrationTestMockClient;
    return await data.get(Uri.parse(path));
  }
}
