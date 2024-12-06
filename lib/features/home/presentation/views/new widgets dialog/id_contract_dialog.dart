import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/colors.dart';

class IdContractDialog extends StatelessWidget {
  const IdContractDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter your ID",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24, // Font size
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
          // ID Input Field
          TextFormField(
            controller: idController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "ID",
              hintText: "Enter your ID here",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 20),
          // Confirm and Cancel Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog without saving
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: QColors.secondary,
                ),
                onPressed: () {
                  final enteredId = idController.text.trim();
                  if (enteredId.isNotEmpty) {
                    Navigator.pop(
                        context, enteredId); // Close dialog and return ID
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("ID cannot be empty")),
                    );
                  }
                },
                child: const Text("Confirm"),
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
    builder: (BuildContext context) => const IdContractDialog(),
  );
}
