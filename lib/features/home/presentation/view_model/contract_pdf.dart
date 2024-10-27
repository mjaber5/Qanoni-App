import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:qanoni/features/home/presentation/view_model/save_and_open.dart';

class SimplePdfApi {
  static Future<File> generateSimpleTextPdf(String text, String text2) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        customHeader(),
        customHeadLine(),
        ...bulletPoints(),
        SizedBox(height: 10),
        Header(
          text: 'Contract Body',
          textStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
      footer: (context) => buildPageNumber(context),
    ));
    return SaveAndOpenDoucment.savePdf(name: 'demo_contract.pdf', pdf: pdf);
  }

  static Widget customHeader() => Container(
        padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: PdfColors.blue,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'Demo Contracct',
              style: TextStyle(
                fontSize: 24,
                color: PdfColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  static customHeadLine() => Header(
        child: Text(
          'Your Contract',
          style: TextStyle(
            fontSize: 24,
            color: PdfColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.all(10.0),
      );

  static List<Bullet> bulletPoints() => [
        Bullet(
          text: 'First condition',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bulletMargin: const EdgeInsets.only(top: 9, right: 5),
        ),
        Bullet(
          text: 'Second condition',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bulletMargin: const EdgeInsets.only(top: 9, right: 5),
        ),
        Bullet(
          text: 'Third condition',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bulletMargin: const EdgeInsets.only(top: 9, right: 5),
        ),
      ];

  static buildPageNumber(Context context) => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        child: Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
