import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdfViewScreen extends StatelessWidget {
  final String path;
  PdfViewScreen(this.path);
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            primary: false,
            leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back)),
            title: Text("Document")),
        path: path);
  }
}
