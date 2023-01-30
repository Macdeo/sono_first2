import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EcrfRando extends StatelessWidget {
  const EcrfRando({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF6f67f0),
        title: const Text("ECRF Rando"),
      ),
      body: const WebView(
        initialUrl:
            'https://cleanweb-production5.aphp.fr/Ctms-aphp5/portal/login',
      ),
    );
  }
}
