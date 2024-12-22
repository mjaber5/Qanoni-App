import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/data/contract_status/contract_status_cubit.dart';
import 'package:qanoni/features/home/presentation/views/widget_form_input/buyer_contract.dart';
import 'package:qanoni/features/home/presentation/views/widget_form_input/seller_cuntract.dart';

import 'package:user_repository/user_reposetory.dart';

class WaiverContractBottomSheet extends StatefulWidget {
  const WaiverContractBottomSheet({super.key});

  @override
  State<WaiverContractBottomSheet> createState() =>
      _WaiverContractBottomSheetState();
}

class _WaiverContractBottomSheetState extends State<WaiverContractBottomSheet> {
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final FirebaseUserRepo _userRepo = FirebaseUserRepo();
  bool _isTextFieldFocused = false;
  String? _selectedUserType;

  @override
  void initState() {
    super.initState();
    _idFocusNode.addListener(() {
      setState(() {
        _isTextFieldFocused = _idFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _idFocusNode.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> _confirmIdInput(BuildContext context) async {
    final userIduseInput = _idController.text.trim();

    if (userIduseInput.isEmpty) {
      _showSnackBar(context, "Please enter a valid ID.", Colors.red);
      return;
    }

    try {
      final currentUser = _userRepo.firebaseAuth.currentUser;
      if (currentUser == null) {
        log('No user is logged in.');
        _showSnackBar(context, "No user is logged in.", Colors.red);
        return;
      }

      final currentUserDoc =
          await _userRepo.usersCollection.doc(currentUser.uid).get();
      if (!currentUserDoc.exists) {
        log('Current user data not found.');
        _showSnackBar(context, "Current user data not found.", Colors.red);
        return;
      }

      final querySnapshot = await _userRepo.usersCollection
          .where('userIduse', isEqualTo: userIduseInput)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log("User with userIduse $userIduseInput does not exist.");
        _showSnackBar(context, "User with ID $userIduseInput does not exist.",
            Colors.red);
        return;
      }

      final otherUserDoc = querySnapshot.docs.first.data();
      Map<String, dynamic> buyerData = {};
      Map<String, dynamic> sellerData = {};

      if (_selectedUserType == "Buyer") {
        buyerData = otherUserDoc;
      } else if (_selectedUserType == "Seller") {
        sellerData = otherUserDoc;
      }

      context.read<ContractCubit>().createContract(
            currentUser: currentUserDoc.data(),
            otherUserId: userIduseInput,
            userType: _selectedUserType!,
            buyerData: buyerData,
            sellerData: sellerData,
          );
    } catch (error) {
      log('Error validating userIduse: $error');
      _showSnackBar(context, "Error: ${error.toString()}", Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: _isTextFieldFocused
            ? MediaQuery.of(context).viewInsets.bottom
            : 10.0,
      ),
      child: SingleChildScrollView(
        child: BlocConsumer<ContractCubit, ContractStatusState>(
          listener: (context, state) {
            if (state is ContractSuccess) {
              _showSnackBar(context, state.message, Colors.green);
              WidgetsBinding.instance.addPostFrameCallback((_) {});
            } else if (state is ContractError) {
              _showSnackBar(context, state.error, Colors.red);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedUserType == null)
                  const Text(
                    "Who are you?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                _buildUserTypeSelection(),
                const SizedBox(height: 20),
                if (_selectedUserType != null) ...[
                  const Divider(thickness: 1, color: Colors.grey),
                  const SizedBox(height: 20),
                  Text(
                    "Enter ${_selectedUserType == "Buyer" ? "Seller" : "Buyer"} ID",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildIdTextField(),
                  const SizedBox(height: 20),
                  _buildActionButtons(context),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUserTypeButton("Buyer"),
        const Text(
          "or",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildUserTypeButton("Seller"),
      ],
    );
  }

  Widget _buildUserTypeButton(String userType) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        backgroundColor:
            _selectedUserType == userType ? QColors.secondary : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: Colors.black45, // Adding shadow for depth
      ),
      onPressed: () {
        setState(() {
          _selectedUserType = userType;
        });
      },
      child: Text(
        userType,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildIdTextField() {
    return TextFormField(
      controller: _idController,
      focusNode: _idFocusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText:
            "Enter ${_selectedUserType == "Buyer" ? "Seller" : "Buyer"} ID",
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
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _selectedUserType = null;
              _idController.clear();
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            backgroundColor: QColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            shadowColor: Colors.black45,
          ),
          onPressed: () {
            if (_selectedUserType == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a contract type')),
              );
            } else {
              _confirmIdInput(context);

              if (_selectedUserType == 'Buyer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BuyerContract()),
                );
              } else if (_selectedUserType == 'Seller') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SellerContract()),
                );
              }
            }
          },
          child: const Text(
            "Confirm",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
