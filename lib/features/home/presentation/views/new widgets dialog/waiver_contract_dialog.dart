import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import '../../../../../core/utils/constants/colors.dart';

class WaiverContractDialog extends StatelessWidget {
  const WaiverContractDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
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
                    showIdDialog(context, "Seller"); // Show seller ID dialog
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
                    showIdDialog(context, "Buyer"); // Show buyer ID dialog
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

void showWaiverContractDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const WaiverContractDialog(),
  );
}

void showIdDialog(BuildContext context, String userType) {
  final TextEditingController idController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter $userType ID"), // Dynamically change dialog title
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final enteredId = idController.text.trim();
              if (enteredId.isNotEmpty) {
                GoRouter.of(context).pushReplacement(AppRouter.kCreateContract);
                Navigator.pop(
                    context, enteredId); // Close the dialog and return the ID
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      );
    },
  );
}
