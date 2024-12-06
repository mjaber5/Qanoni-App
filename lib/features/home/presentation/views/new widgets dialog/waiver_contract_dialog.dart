// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/data/contract_status/contract_status_cubit.dart';
import 'package:user_repository/user_reposetory.dart'; // Import your FirebaseUserRepo

class WaiverContractBottomSheet extends StatefulWidget {
  const WaiverContractBottomSheet({super.key});

  @override
  State<WaiverContractBottomSheet> createState() =>
      _WaiverContractBottomSheetState();
}

class _WaiverContractBottomSheetState extends State<WaiverContractBottomSheet> {
  final TextEditingController idController = TextEditingController();
  final FocusNode idFocusNode = FocusNode();
  final FirebaseUserRepo _userRepo = FirebaseUserRepo();
  bool isTextFieldFocused = false;
  String? selectedUserType;

  @override
  void initState() {
    super.initState();
    idFocusNode.addListener(() {
      setState(() {
        isTextFieldFocused = idFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    idFocusNode.dispose();
    idController.dispose();
    super.dispose();
  }

  Future<void> _confirmIdInput(BuildContext context) async {
    final enteredId = idController.text.trim();

    if (enteredId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid ID."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Fetch the current user
      final currentUser = _userRepo.firebaseAuth.currentUser;

      if (currentUser == null) {
        throw Exception("No user is logged in.");
      }

      // Fetch current user data from Firestore using FirebaseUserRepo
      final currentUserDoc =
          await _userRepo.usersCollection.doc(currentUser.uid).get();

      if (!currentUserDoc.exists) {
        throw Exception("Current user data not found.");
      }

      // Extract the data from Firestore as a map
      final currentUserData = currentUserDoc.data();

      // Call the Cubit method to create the contract with all required arguments
      context.read<ContractCubit>().createContract(
            currentUser: currentUserData, // Pass the Firestore user data
            otherUserId: enteredId, // Pass the entered ID
            userType:
                selectedUserType!, // Pass the selected user type (Buyer/Seller)
          );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${error.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
            : 10.0,
      ),
      child: SingleChildScrollView(
        child: BlocConsumer<ContractCubit, ContractStatusState>(
          listener: (context, state) {
            if (state is ContractSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ContractError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedUserType == null)
                  const Text(
                    "Who are you?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        backgroundColor: selectedUserType == "Buyer"
                            ? QColors.secondary
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
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        backgroundColor: selectedUserType == "Seller"
                            ? QColors.secondary
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: idController,
                    focusNode: idFocusNode,
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
                        onPressed: () => _confirmIdInput(context),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
