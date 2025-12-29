import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  final _errorTitle = "Serie nicht gefunden";
  final String errorText;

  const ErrorScreenWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_errorTitle)),
        body: Center(child: Text(errorText)));
  }
}
