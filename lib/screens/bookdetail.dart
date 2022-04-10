import 'package:flutter/material.dart';
import 'package:handlib/models/booklists.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Book_content extends StatefulWidget {
  static const routeName = '/book_content';
  const Book_content({Key? key}) : super(key: key);

  @override
  FlipState createState() => FlipState();
}

class FlipState extends State<Book_content> {
  double x = 0;
  double y = 0;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    // gyroscopeEvents.listen((GyroscopeEvent event) {
    //   x = event.y;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Book;
    int page = 1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: StreamBuilder<GyroscopeEvent>(
          stream: SensorsPlatform.instance.gyroscopeEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              x = snapshot.data!.x;
              y = snapshot.data!.y;
              print([x, y]);
              if (y > 0) {
                _pdfViewerController.jumpToPage(page + 1);
              } else if (y < 0) {
                if (page == 1) {
                  _pdfViewerController.jumpToPage(1);
                } else {
                  _pdfViewerController.jumpToPage(page - 1);
                }
              }
            }
            return SfPdfViewer.asset(
              data.pdf,
              pageLayoutMode: PdfPageLayoutMode.single,
              onPageChanged: (PdfPageChangedDetails details) {
                // print('New page');
                // print(details.newPageNumber);
                page = details.newPageNumber;
              },
              controller: _pdfViewerController,
            );
          }),
    );
  }
}
