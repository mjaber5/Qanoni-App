import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/data/contract_status/contract_status_cubit.dart';

import 'all.dart';
import 'done.dart';
import 'request.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key});

  @override
  State<NotificationContent> createState() => NotificationContentState();
}

class NotificationContentState extends State<NotificationContent> {
  String selectedItem = "All";
  final PageController _pageController = PageController();

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
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            buildTab("All", 0),
            const SizedBox(width: 4),
            buildTab("Request", 1),
            const SizedBox(width: 4),
            buildTab("Progress status", 2),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                if (index == 0) {
                  selectedItem = "All";
                } else if (index == 1) {
                  selectedItem = "Request";
                } else if (index == 2) {
                  selectedItem = "Progress status";
                }
              });
            },
            children: [
              const All(),
              // Using BlocBuilder to listen for the enteredUserId from ContractCubit
              BlocBuilder<ContractCubit, ContractStatusState>(
                builder: (context, state) {
                  // Get the enteredUserId from the cubit
                  String enteredUserId =
                      context.read<ContractCubit>().getEnteredUserId();
                  return Request(
                    enteredUserId: enteredUserId,
                    contractId: '',
                  );
                },
              ),
              const Done(),
            ],
          ),
        ),
      ],
    );
  }
}
