import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../lease contracts/house_rental_contact/contract_input_form_hose.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization package

class AceaptHouse extends StatefulWidget {
  const AceaptHouse({super.key});

  @override
  State<AceaptHouse> createState() => _AceaptPageState();
}

class _AceaptPageState extends State<AceaptHouse> {
  bool _agreed = false; // Declare _agreed here

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.acceptHouseTitle, // Use localization for title
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDarkMode ? QColors.darkerGrey : QColors.secondary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.terms_intro, // استخدام نص الترجمة
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Contract terms container
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode
                          ? [QColors.darkerGrey.withOpacity(0.8), QColors.darkerGrey.withOpacity(0.6)]
                          : [Colors.white, Colors.grey[200]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDarkMode ? Colors.white54 : Colors.grey.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.4)
                            : Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      localizations.houseRentContract, // Use localization for terms
                      style: const TextStyle(fontSize: 16.0, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Agreement checkbox
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
                Expanded(
                  child: Text(
                    localizations.agree_text, // Use localization for agreement text
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Button to proceed
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
                                builder: (context) => const ContractInputFormHouse(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: _agreed ? QColors.secondary : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      localizations.start_button, // Use localization for button text
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
