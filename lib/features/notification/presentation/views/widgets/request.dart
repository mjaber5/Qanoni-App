import 'dart:developer';
import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  final String enteredUserId;
  final String contractId;

  const Request(
      {super.key, required this.enteredUserId, required this.contractId});

  Widget buildNotificationList(
      String type, String userId, BuildContext context) {
    // Sample contract data for design purposes
    String sellerId = 'sellerIdSample'; // Sample seller ID for comparison
    String buyerId = 'buyerIdSample'; // Sample buyer ID for comparison
    String sellerName = 'John Doe'; // Placeholder for seller name
    String buyerName = 'Jane Smith'; // Placeholder for buyer name
    String contractStatus = 'Pending'; // Placeholder for contract status
    String contractDate = '2024-12-07'; // Placeholder for contract date

    // Log entered user ID and contract ID
    log('Entered User ID: $userId');
    log('Contract ID: $contractId');

    // Check if the entered user is either the seller or buyer
    bool hasRequest = (userId == sellerId || userId == buyerId);

    // Add log to check if the request exists
    log('Has Request: $hasRequest');

    if (hasRequest) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.request_page, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$type Notification",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Contract between $sellerName and $buyerName",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Contract Status: $contractStatus",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Date: $contractDate",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      log('Reject contract $contractId');
                      // Handle reject logic, update state, or notify user
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      log('Approve contract $contractId');
                      // Trigger contract approval logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          "No Requests",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: buildNotificationList("Request", enteredUserId, context),
            ),
          ],
        ),
      ),
    );
  }
}
