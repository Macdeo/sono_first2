import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Protocole extends StatelessWidget {
  const Protocole({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF6f67f0),
        title: const Text("Protocole"),
      ),
      body: const WebView(
        initialUrl: 'https://clinicaltrials.gov/ct2/show/NCT04614493',
      ),
    );
  }
}
