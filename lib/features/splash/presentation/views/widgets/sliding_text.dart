import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/text_strings.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) => SlideTransition(
        position: slidingAnimation,
        child: const Text(
          QTexts.splashSupTitle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
