import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants/colors.dart';
import 'contract_input_form_public_servic.dart';

class AceptPublicServic extends StatefulWidget {
  const AceptPublicServic({super.key});

  @override
  State<AceptPublicServic> createState() => _AceaptPageState();
}

class _AceaptPageState extends State<AceptPublicServic> {
  bool _agreed = false; // Declare _agreed here

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
                  decoration: BoxDecoration(
                    color: QColors.darkerGrey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Text(
                    '''[الشروط 


                    Acept Public Servic
                      
                      
                      
                      
                      
                                                                                                                      j
                      
                      
                      
                      
                      
                                                                                                                      j
                      
                      
                      
                      
                      
                      
                                                                                          j
                      
                      
                      
                      
                      
                      j                                                                                          ]''',
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
                            // navigate
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContractInputFormPublicServic()));
                          }
                        : null,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(QColors.secondary)),
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
