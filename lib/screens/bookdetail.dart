import 'dart:async';

import 'package:flutter/material.dart';
import 'package:handlib/models/booklists.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:sensors/sensors.dart';

// class Book_content extends StatelessWidget {
//   static const routeName = '/book_content';
//   const Book_content({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final data = ModalRoute.of(context)!.settings.arguments as Book;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(data.title),
//       ),
//       body: SfPdfViewer.asset(
//         data.pdf,
//         pageLayoutMode: PdfPageLayoutMode.single,
//       ),
//     );
//   }
// }

class Book_content extends StatefulWidget {
  static const routeName = '/book_content';
  const Book_content({Key? key}) : super(key: key);

  @override
  FlipState createState() => FlipState();
}

class FlipState extends State<Book_content> {
  double y = 0;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      y = event.y;
      if (y > 0)
        _pdfViewerController.nextPage();
      else if (y < 0) _pdfViewerController.previousPage();
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Book;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: SfPdfViewer.asset(
        data.pdf,
        pageLayoutMode: PdfPageLayoutMode.single,
        controller: _pdfViewerController,
      ),
    );
  }
}
