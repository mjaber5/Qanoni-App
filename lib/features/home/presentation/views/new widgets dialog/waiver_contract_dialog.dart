import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import '../../../../../core/utils/constants/colors.dart';

class WaiverContractBottomSheet extends StatefulWidget {
  const WaiverContractBottomSheet({super.key});

  @override
  State<WaiverContractBottomSheet> createState() =>
      _WaiverContractBottomSheetState();
}

class _WaiverContractBottomSheetState extends State<WaiverContractBottomSheet> {
  String? selectedUserType; // نوع المستخدم المختار (بائع أو مشتري)
  final TextEditingController idController = TextEditingController();
  final FocusNode idFocusNode = FocusNode(); // لمراقبة التركيز على حقل الإدخال
  bool isTextFieldFocused = false; // لتحديد إذا كان الـ TextField مفعلاً

  @override
  void initState() {
    super.initState();
    idFocusNode.addListener(() {
      setState(() {
        isTextFieldFocused = idFocusNode.hasFocus; // تحديث حالة التركيز
      });
    });
  }

  @override
  void dispose() {
    idFocusNode.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: isTextFieldFocused
            ? MediaQuery.of(context).viewInsets.bottom
            : 10.0, // إضافة مسافة عند ظهور لوحة المفاتيح
      ),
      child: SingleChildScrollView(
        child:Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    if (selectedUserType == null)
      const Text(
        "Who are you?",
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    const SizedBox(height: 20),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // زر المشتري
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            backgroundColor: selectedUserType == "Buyer"
                ?QColors.secondary
                : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          onPressed: () {
            setState(() {
              selectedUserType = "Buyer";
            });
          },
          child: const Text(
            "Buyer",
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Text(
          "or",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        // زر البائع
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            backgroundColor: selectedUserType == "Seller"
                ?QColors.secondary
                : Colors.grey,
            shape: RoundedRectangleBorder(
             
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          onPressed: () {
            setState(() {
              selectedUserType = "Seller";
            });
          },
          child: const Text(
            "Seller",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    ),
    const SizedBox(height: 20),
    if (selectedUserType != null) ...[
      const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      const SizedBox(height: 20),
      Text(
        "Enter ${selectedUserType == "Buyer" ? "Seller" : "Buyer"} ID",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: idController,
        focusNode: idFocusNode, // ربط TextField مع الـ FocusNode
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Enter $selectedUserType ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: QColors.secondary,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: const Icon(
            Icons.person,
            color: QColors.secondary,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedUserType = null;
                idController.clear();
              });
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              backgroundColor: QColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: () {
              final enteredId = idController.text.trim();
              if (enteredId.isNotEmpty) {
                GoRouter.of(context)
                    .pushReplacement(AppRouter.kCreateContract);
                Navigator.pop(context, enteredId);
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ],
  ],
),

      ),
    );
  }
}

void showWaiverContractBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // يجعل البوتوم شيت يستجيب لظهور الكيبورد
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) => const WaiverContractBottomSheet(),
  );
}
