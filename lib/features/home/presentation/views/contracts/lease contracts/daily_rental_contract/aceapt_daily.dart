import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // استيراد ملف الترجمة
import '../../../../../../../core/utils/constants/colors.dart';
import '../../lease contracts/daily_rental_contract/contract_input_form_daily.dart';

class AceaptDaily extends StatefulWidget {
  const AceaptDaily({super.key});

  @override
  State<AceaptDaily> createState() => _AceaptPageState();
}

class _AceaptPageState extends State<AceaptDaily> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context)!; // استدعاء الترجمة

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.terms_title, // استخدام نص الترجمة
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Text(
                          localizations.terms_intro, // استخدام نص الترجمة
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            const SizedBox(height: 12),
                            Text(
                              '1. ${localizations.condition_1}', // استخدام نصوص مترجمة
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '2. ${localizations.condition_2}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '3. ${localizations.condition_3}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '4. ${localizations.condition_4}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            // يمكنك إضافة المزيد من الشروط هنا
                          ],
                        ),
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
                    localizations.agree_text, // استخدام نص الترجمة
                    style: const TextStyle(fontSize: 16.0),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ContractInputFormDaily(),
                              ),
                            );
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(QColors.secondary),
                    ),
                    child: Text(
                      localizations.start_button, // استخدام نص الترجمة
                      style: const TextStyle(color: Colors.white),
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
