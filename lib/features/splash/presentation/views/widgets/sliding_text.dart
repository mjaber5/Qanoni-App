import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../../core/utils/theme/change_theme_notifire.dart';
import '../../../../../core/utils/theme/custom_themes/text_theme.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) => SlideTransition(
        position: slidingAnimation,
        child: Text(
          QTexts.splashSupTitle,
          textAlign: TextAlign.center,
          style: isLight
              ? QTextTheme.darkTextTheme.bodyLarge
              : QTextTheme.lightTextTheme.bodyLarge,
        ),
      ),
    );
  }
}
