import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import the localization file
import '../../../../../../../core/utils/constants/colors.dart';
import 'contract_input_form_car.dart';




class SalesCarAcept extends StatefulWidget {
  const SalesCarAcept({super.key});

  @override
  State<SalesCarAcept> createState() => _EquipmentAcepetState();
}

class _EquipmentAcepetState extends State<SalesCarAcept> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.terms_title,
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
            Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  localizations.read_terms,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.terms_header, // Localized header
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        // Use localized strings for the terms
                        
                          Text(
                            localizations.equipment_terms,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Agreement checkbox and button
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
                    localizations.agree_text, // Localized agreement text
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
                                builder: (context) => const ContractInputFormCarSales(), // Ensure the class name is correct
                              ),
                            );
                          }
                        : null, // Disable button if not agreed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: _agreed ? QColors.secondary : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      localizations.start_button, // Localized button text
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
