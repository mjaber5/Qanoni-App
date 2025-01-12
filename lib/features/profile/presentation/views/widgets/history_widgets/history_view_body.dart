import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qanoni/core/services/base.dart';
import 'package:qanoni/features/payment/presentation/view/payment_view.dart';
import 'dart:convert';

import 'custom_history_app_bar.dart';

class HistoryViewBody extends StatefulWidget {
  const HistoryViewBody({super.key});

  @override
  State<HistoryViewBody> createState() => _HistoryViewBodyState();
}

class _HistoryViewBodyState extends State<HistoryViewBody> {
  late Future<List<dynamic>> contractsFuture;
  String baseUri = ConfigApi.baseUri;

  @override
  void initState() {
    super.initState();
    contractsFuture = fetchContracts();
  }

  Future<List<dynamic>> fetchContracts() async {
    final String apiUrl = '$baseUri/fetch-contracts';
    log('API URL: $apiUrl');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'filters': {}, // Example filters
          'limit': 100,
          'offset': 0,
        }),
      );
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('Contracts Data: $data');
        return data['contracts'];
      } else {
        log('Failed to load contracts: ${response.statusCode}');
        throw Exception('Failed to load contracts');
      }
    } catch (e) {
      log('Error fetching contracts: $e');
      throw Exception('Error fetching contracts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHistoryAppBar(),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: contractsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No contracts found'),
                );
              } else {
                final contracts = snapshot.data!;
                return ListView.builder(
                  itemCount: contracts.length,
                  itemBuilder: (context, index) {
                    final contract = contracts[index];
                    return ContractCard(contract: contract);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class ContractCard extends StatelessWidget {
  final dynamic contract;

  const ContractCard({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contract ID: ${contract['id'] ?? 'N/A'}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${contract['status'] ?? 'N/A'}',
              style: TextStyle(
                color: contract['status'] == 'approved'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buyer: ${contract['buyer']['fullName'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Seller: ${contract['seller']['fullName'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContractDetailsView(
                      contract: contract,
                    ),
                  ),
                );
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContractDetailsView extends StatelessWidget {
  final dynamic contract;

  const ContractDetailsView({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Contract Details',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Contract ID: ${contract['id'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${contract['status'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 16,
                color: contract['status'] == 'approved'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buyer: ${contract['buyer']['fullName'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Seller: ${contract['seller']['fullName'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Additional Details',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: ${contract['amount'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Created At: ${contract['createdAt'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Updated At: ${contract['updatedAt'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Additional Terms: ${contract['additionalTerms'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaymentDetailsView()));
              },
              child: const Text('Proceed with Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
