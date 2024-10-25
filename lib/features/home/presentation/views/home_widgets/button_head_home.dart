import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ButtonHomeView extends StatelessWidget {
  const ButtonHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.35, // Slightly increased height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          gradient: const LinearGradient(
            colors: [QColors.darkerGrey, Colors.black], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 25,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with text "Qanoni"
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment, // Changed icon to represent contracts
                    color: Colors.white,
                    size: 80, // Icon size
                  ),
                  SizedBox(width: 10),
                  Text(
                    localizations.qanoni,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48, // Font size
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Brief Description
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
localizations.descAppContenar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20, // Font size
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Action Button (optional)
              // 
              const SizedBox(height: 15),
              // Additional Decorative Element (optional)
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
