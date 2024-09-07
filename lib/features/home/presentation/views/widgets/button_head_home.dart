import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

class ButtonHomeView extends StatelessWidget {
  const ButtonHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isLight ? QColors.dark : QColors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            1,
            (rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (colIndex) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: QColors.secondary,
                          ),
                          child: const Icon(Icons.description_outlined),
                        ),
                        const Text('data'),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
