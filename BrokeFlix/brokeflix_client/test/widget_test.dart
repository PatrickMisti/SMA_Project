// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brokeflix_client/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Counter increments smoke test', () async {
    // Build our app and trigger a frame.
    var request = http.Request('GET', Uri.parse('https://zero.mistlberger.dev/v1/api/serienstream/popular'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  });
}
