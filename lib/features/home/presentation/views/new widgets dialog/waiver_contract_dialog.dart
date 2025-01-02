import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';

import 'package:qanoni/features/notification/presentation/view_model/notification_cubit/notifications_cubit.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class WaiverContractBottomSheet extends StatefulWidget {
  const WaiverContractBottomSheet({super.key});

  @override
  State<WaiverContractBottomSheet> createState() =>
      _WaiverContractBottomSheetState();
}

class _WaiverContractBottomSheetState extends State<WaiverContractBottomSheet> {
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
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
    // Request notification permissions at startup
    context
        .read<NotificationsCubit>()
        .initializeNotifications(_idController.text);
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

    if (_selectedUserType == null) {
      _showSnackBar(
          context, "Please select a user type (Buyer/Seller).", Colors.red);
      return;
    }

    // Trigger contract creation and notification through NotificationsCubit
    context.read<NotificationsCubit>().createContractAndNotify(
          userIduseInput,
          _selectedUserType!,
        );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUserTypeButton("Buyer"),
        const Text("or",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      onPressed: () {
        setState(() {
          _selectedUserType = userType;
        });
      },
      child: Text(userType, style: const TextStyle(fontSize: 18)),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: QColors.secondary, width: 2.0),
        ),
        filled: true,
        prefixIcon: const Icon(Icons.person, color: QColors.secondary),
      ),
    );
  }

  void countinueContract() {
    GoRouter.of(context).push(_selectedUserType == 'buyer'
        ? AppRouter.kBuyerContract
        : AppRouter.kSellerContract);
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
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            backgroundColor: QColors.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            shadowColor: Colors.black45,
          ),
          onPressed: () {
            countinueContract();
            _confirmIdInput(context);
          },
          child: const Text("Confirm", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationError) {
          _showSnackBar(context, state.error, Colors.red);
        } else if (state is ContractCreated) {
          _showSnackBar(
              context, 'Contract created successfully!', Colors.green);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: _isTextFieldFocused
              ? MediaQuery.of(context).viewInsets.bottom
              : 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedUserType == null)
                const Text(
                  "Who are you?",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildIdTextField(),
                const SizedBox(height: 20),
                _buildActionButtons(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
