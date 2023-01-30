import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Guideline extends StatefulWidget {
  const Guideline({Key? key}) : super(key: key);

  @override
  _GuidelineState createState() => _GuidelineState();
}

class _GuidelineState extends State<Guideline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Guideline",
          ),
          backgroundColor: const Color(0XFF6f67f0),
        ),
        body: SfPdfViewer.asset('pdf/pdfclin.pdf',
            enableDoubleTapZooming: false));
  }
}
