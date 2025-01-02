import 'dart:convert';
import 'package:http/http.dart' as http;

class ContractRepo {
  final String baseUrl;

  ContractRepo({required this.baseUrl});

  Future<void> createContract({
    required String buyerIduse,
    required String sellerIduse,
    required Map<String, dynamic> contractDetails,
  }) async {
    final url = Uri.parse('$baseUrl/create-contract');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'buyerIduse': buyerIduse,
        'sellerIduse': sellerIduse,
        'contractDetails': contractDetails,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create contract: ${response.body}');
    }
  }

  Future<void> approveContract(String contractId) async {
    final url = Uri.parse('$baseUrl/approve-contract/$contractId');
    final response = await http.post(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to approve contract: ${response.body}');
    }
  }

  Future<void> rejectContract(String contractId) async {
    final url = Uri.parse('$baseUrl/reject-contract/$contractId');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to reject contract: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchContract(String contractId) async {
    final url = Uri.parse('$baseUrl/contract/$contractId');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch contract: ${response.body}');
    }

    return jsonDecode(response.body);
  }
}
