import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportWebView extends StatefulWidget {
  final String url;

  const ReportWebView({super.key, required this.url});

  @override
  State<ReportWebView> createState() => _ReportWebViewState();
}

class _ReportWebViewState extends State<ReportWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
