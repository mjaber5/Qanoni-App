import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import '../../lease%20contracts/rental_contract_cancellation/contract_Input_form_cancellation.dart';

class CancellationAceept extends StatefulWidget {
  const CancellationAceept({super.key});

  @override
  State<CancellationAceept> createState() => _CancellationAceeptState();
}

class _CancellationAceeptState extends State<CancellationAceept> {
  bool _agreed = false; // Declare _agreed variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: QColors.darkerGrey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Text(
                    '''[الشروط 

                    Daily rent contract عقد ايجار بيت
                      daddssddsssssssssss
                      الشروط والبنود المتعلقة بعقد بيع السيارة، وأي التزامات أو حقوق مترتبة على البيع
                      يجب الاطلاع على كل التفاصيل المتعلقة قبل الموافقة والتوقيع على العقد.
                      
                      
                      ]''',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: _agreed,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreed = value ?? false;
                    });
                  },
                  activeColor: QColors.secondary,
                ),
                const Expanded(
                  child: Text(
                      'I have read and agree with the above terms and conditions'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _agreed
                        ? () {
                            // Navigate to the next page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ContractInputFormCancellation(),
                              ),
                            );
                          }
                        : null, // Disable button if not agreed
                    style: ElevatedButton.styleFrom(
                      backgroundColor: QColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
