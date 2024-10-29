import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // إضافة استيراد الترجمة
import '../../lease contracts/daily_rental_contract/contract_input_form_daily.dart';
import '../../../../../../../core/utils/constants/colors.dart';

class AceaptEquipment extends StatefulWidget {
  const AceaptEquipment({super.key});

  @override
  State<AceaptEquipment> createState() => _AceaptPageState();
}

class _AceaptPageState extends State<AceaptEquipment> {
  bool _agreed = false; // Declare _agreed here

  @override
  Widget build(BuildContext context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.app_bar_title), // استخدام الترجمة
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Text(
                          AppLocalizations.of(context)!.terms_intro, // استخدام نص الترجمة
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                    Container(
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
                      padding: const EdgeInsets.all(16.0), // Add padding inside the container
                      child: Text(
                        AppLocalizations.of(context)!.terms_and_conditions1, // استخدام الترجمة
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
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
                Expanded(
                  child: Text(
                      AppLocalizations.of(context)!.agree_text), // استخدام الترجمة
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
                            // navigate to the daily rental contract form
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContractInputFormDaily()));
                          }
                        : null,
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(QColors.secondary)),
                    child: Text(
                      AppLocalizations.of(context)!.start_button, // استخدام الترجمة
                      style: const TextStyle(color: Colors.white),
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
