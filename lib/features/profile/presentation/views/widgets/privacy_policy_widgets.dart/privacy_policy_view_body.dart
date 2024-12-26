import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/privacy_policy_widgets.dart/cutsom_privacy_policy_app_bar.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomPrivacyPolicyAppBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Privacy Policy Details", // Heading text
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  "This is the body of the privacy policy. Here you can outline the purpose, rules, and regulations regarding data collection, storage, and usage in your app. Ensure the text is clear, concise, and informative for users to understand their rights and obligations.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6, // Better line height for readability
                      ),
                  textAlign:
                      TextAlign.justify, // Justified text for professionalism
                ),
                const SizedBox(height: 20),
                Text(
                  "Additional Information", // Subheading
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Here you can add additional information, such as third-party services used, user rights, or steps users can take to manage their data within the app.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement action (e.g., navigate back or accept terms)
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text("Accept and Continue"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded button
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
