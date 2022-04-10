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
  late AccelerometerEvent event;
  late StreamSubscription accel;
  late PdfViewerController _pdfViewerController;
  bool sensorIsActived = false;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState(); 
  }

  double right = 180;
  double left = 180;
  int count = 0;

  void setPosition(AccelerometerEvent event) {
    if (event == null) {
      return;
    }
    setState(() {
      left = ((event.x * 20) + 160);
    });
    setState(() {
      right = ((event.x * 20) - 160);
    });
  }

  void startRead() {
    if (accel == null) {
      accel = accelerometerEvents.listen((AccelerometerEvent eve) {
        setState(() {
          event = eve;
        });
      });
    } else {
      accel.resume();
    }
  }

  @override
  void dispose() {
    accel.cancel();
    super.dispose();
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
