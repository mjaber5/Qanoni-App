import 'package:flutter/material.dart';

class Request extends StatelessWidget {
  final String enteredUserId;
  final String contractId; // Add contractId to differentiate between contracts

  const Request(
      {super.key, required this.enteredUserId, required this.contractId});

  // Helper function to build the notification list
  Widget buildNotificationList(String type, String userId) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3, // Assuming we have 3 contracts for demo
      itemBuilder: (context, index) {
        // Replace this with actual data fetching (contractId, sellerId, buyerId, etc.)
        String sellerId =
            'sellerIdSample'; // Example seller ID (fetch from Firestore)
        String buyerId =
            'buyerIdSample'; // Example buyer ID (fetch from Firestore)

        if (userId == sellerId || userId == buyerId) {
          // If entered userId matches seller or buyer ID
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  width: 0.15,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15),
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
                              "$type Notification ${index + 1}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "This is a detailed description of the notification.",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "User ID: $userId",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
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
                          // Approve logic
                          print('Approve contract $contractId');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Approve'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Reject logic
                          print('Reject contract $contractId');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Reject'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          // If userId does not match, show a no requests message
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  width: 0.15,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
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
                          "$type Notification ${index + 1}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "This is a detailed description of the notification.",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "No Requests",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 18),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Notifications"),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildNotificationList("Request", enteredUserId),
          ),
        ],
      ),
    );
  }
}
