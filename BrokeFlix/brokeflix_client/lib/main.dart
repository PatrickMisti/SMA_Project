
import 'package:brokeflix_client/core/shared/data_service.dart';
import 'package:brokeflix_client/core/shared/utils/app_logger.dart';
import 'package:brokeflix_client/ui/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

void main() async {
  await dotenv.load();
  AppLogger.config(level: Level.FINER);
  DataService.props();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final title = "BrokeFlix";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark(),
      home: DashboardView(),
    );
  }
}
