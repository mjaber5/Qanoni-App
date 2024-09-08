import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/views/card/lease_card/house_rental_contact/contract_Input_form.dart';

class AceaptHouse extends StatefulWidget {
  const AceaptHouse({super.key});

  @override
  State<AceaptHouse> createState() => _AceaptPageState();
}

class _AceaptPageState extends State<AceaptHouse> {
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

                    House rent contract عقد ايجار بيت
                      
                      
                      
                      
                      
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
                                    builder: (context) => ContractInputForm()));
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
