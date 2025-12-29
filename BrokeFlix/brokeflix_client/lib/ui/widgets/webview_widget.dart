
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageWidget extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPageWidget({super.key, required this.title, required this.url});

  @override
  State<WebViewPageWidget> createState() => _WebViewPageWidgetState();
}

class _WebViewPageWidgetState extends State<WebViewPageWidget> {
  late final WebViewController _controller;
  int _progress = 0;

  void updateProcess(int process) {
    debugPrint("Update process $process");
    setState(() {
      _progress = process;
    });
  }

  @override
  void initState() {
    super.initState();

    if(WebViewPlatform.instance == null){
      debugPrint("Nulllllllllllllllllllll");
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(onProgress: (p) => setState(() => _progress = p)),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: _progress < 100
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(value: _progress / 100),
              )
            : null,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
