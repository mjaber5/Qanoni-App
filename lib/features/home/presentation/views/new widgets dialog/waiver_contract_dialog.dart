import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import '../../../../../core/utils/constants/colors.dart';

class WaiverContractBottomSheet extends StatelessWidget {
  const WaiverContractBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Are you?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.white54,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Buyer Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  onPressed: () {
                    showIdBottomSheet(context, "Seller"); // Show seller ID bottom sheet
                  },
                  child: const Text("Buyer"),
                ),
              ),
              const SizedBox(width: 10),
              const Text("or"),
              const SizedBox(width: 10),
              // Seller Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    showIdBottomSheet(context, "Buyer"); // Show buyer ID bottom sheet
                  },
                  child: const Text("Seller"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showWaiverContractBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => const WaiverContractBottomSheet(),
  );
}

void showIdBottomSheet(BuildContext context, String userType) {
  final TextEditingController idController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter $userType ID", // Dynamically change bottom sheet title
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "$userType ID",
                hintText: "Enter $userType ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final enteredId = idController.text.trim();
                    if (enteredId.isNotEmpty) {
                      GoRouter.of(context).pushReplacement(AppRouter.kCreateContract);
                      Navigator.pop(context, enteredId); // Close the bottom sheet and return the ID
                    }
                  },
                  child: const Text("Confirm"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
