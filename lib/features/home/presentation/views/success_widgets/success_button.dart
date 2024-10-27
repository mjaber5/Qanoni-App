import 'package:flutter/material.dart';
import 'package:qanoni/features/home/presentation/view_model/contract_pdf.dart';
import 'package:qanoni/features/home/presentation/view_model/save_and_open.dart';

class SuccessButton extends StatelessWidget {
  const SuccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () async {
              final simplePdfFile = await SimplePdfApi.generateSimpleTextPdf(
                'Sample Text',
                'Flutter Developer',
              );
              SaveAndOpenDoucment.openPdf(simplePdfFile);
            },
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
