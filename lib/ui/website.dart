import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Website extends StatelessWidget {
  const Website({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF6f67f0),
        title: const Text("Website"),
      ),
      body: const WebView(
        initialUrl: 'https://sonofirst-trial.eu',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
