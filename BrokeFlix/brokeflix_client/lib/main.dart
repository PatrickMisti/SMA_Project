
import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/ui/views/dashboard_view.dart';
import 'package:flutter/material.dart';

void main() {
  DataService.props();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      theme: ThemeData.dark(),
      home: DashboardView(),
    );
  }
}
