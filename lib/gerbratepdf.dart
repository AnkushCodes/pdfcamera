import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class Genpdf {
  File file;
  Genpdf(this.file);
  final pdf = pw.Document();
  var image;
  DateTime date = DateTime.now();
  String dt = "";
  setval() {
    dt = DateFormat('yyyy/MM/dd  kk:mm').format(date);
    image = PdfImage.file(pdf.document, bytes: file.readAsBytesSync());
  }

  genratepdf() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(              
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text('Pdf',style: pw.TextStyle(fontSize: 40)),
                  ]
                ),
                pw.Spacer(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [pw.Image(image,height: 150,width: 150), pw.Text(dt.toString())])
              ] // Center
              );
        },
      ),
    );
    final output = await getExternalStorageDirectory();
    final file1 = File('${output.path}/example8.pdf');
    await file1.writeAsBytesSync(pdf.save());
  }
}
