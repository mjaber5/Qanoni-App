import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/notification/presentation/view_model/notification_cubit/notifications_cubit.dart';
import 'package:qanoni/features/notification/presentation/views/widgets/request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // أضف هذا السطر


import 'all.dart';
import 'done.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key});

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  String selectedItem = "All";
  final PageController _pageController = PageController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      log('User logged in with ID: ${currentUser!.uid}');
      context.read<NotificationsCubit>().initializeNotifications(
            currentUser!.uid,
          );
    } else {
      log('Error: User is not logged in.');
    }
  }

  Widget buildTab(String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedItem = label;
          _pageController.jumpToPage(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color:
                selectedItem == label ? QColors.secondary : Colors.transparent,
            border: Border.all(
              color: selectedItem == label
                  ? QColors.secondary
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              width: selectedItem == label ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color: selectedItem == label
                    ? Colors.white
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is NotificationClicked) {
          log('Notification clicked: ${state.contractId}');
          _pageController.jumpToPage(1); // Navigate to the "Request" tab
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 4),
              buildTab(AppLocalizations.of(context)!.all, 0),
              const SizedBox(width: 4),
              buildTab(AppLocalizations.of(context)!.request, 1),
              const SizedBox(width: 4),
              buildTab(AppLocalizations.of(context)!.progress_status, 2),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedItem = ["All", "Request", "Progress status"][index];
                });
              },
              children: [
                const All(),
                FutureBuilder<QuerySnapshot>(
                  future: _firestore
                      .collection('contracts')
                      .where('status', isEqualTo: 'pending')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_pending_contracts,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    // Parse the first document as a Waiver
                    final waiver =
                        Waiver.fromDocumentSnapshot(snapshot.data!.docs.first);

                    return RequestScreen(
                      contractId: waiver.contractId,
                      messageTitle: AppLocalizations.of(context)!.contract_request_title,
                      messageBody:
                          AppLocalizations.of(context)!.contract_request_body,
                      userType: waiver.userType,
                    );
                  },
                ),
                const Done(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Waiver class to parse Firestore documents
class Waiver {
  final String contractId;
  final String userType;

  Waiver({required this.contractId, required this.userType});

  factory Waiver.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Waiver(
      contractId: doc.id,
      userType: data['userType'] ?? 'unknown',
    );
  }
}
