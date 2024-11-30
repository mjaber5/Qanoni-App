import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/utils/constants/colors.dart';

class ButtonHomeView extends StatefulWidget {
  const ButtonHomeView({super.key});

  @override
  _ButtonHomeViewState createState() => _ButtonHomeViewState();
}

class _ButtonHomeViewState extends State<ButtonHomeView> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [QColors.darkerGrey, Colors.black],
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (pageIndex) {
                setState(() {
                  _currentPage = pageIndex.toDouble();
                });
              },
              children: [
                _buildPage(localizations.qanoni, localizations.descAppContenar),
                _buildPage(localizations.qanoni, localizations.descAppContenar),
                // Add more pages as needed
              ],
            ),
            // Animated Position for dots and line
            Positioned(
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentPage == 0 ? 10 : 20,  // Change width based on the active page
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentPage == 0 ? Colors.white : Colors.white54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _currentPage == 1 ? 10 : 20,  // Change width based on the active page
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentPage == 1 ? Colors.white : Colors.white54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Optionally add more dots if you have more pages
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo with text "Qanoni"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment,
              color: Colors.white,
              size: 80,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Action Button (optional)
        const SizedBox(height: 15),
      ],
    );
  }
}
