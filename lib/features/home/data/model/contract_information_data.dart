class ContractInfo {
  final String contractDate;
  final String contractPlace;
  final String saleAmount;
  final String paymentMethod;
  final bool ownershipTransfer;
  final String additionalTerms;

  ContractInfo({
    required this.contractDate,
    required this.contractPlace,
    required this.saleAmount,
    required this.paymentMethod,
    required this.ownershipTransfer,
    required this.additionalTerms,
  });

  // Method to convert data into a Map (e.g., for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'contractDate': contractDate,
      'contractPlace': contractPlace,
      'saleAmount': saleAmount,
      'paymentMethod': paymentMethod,
      'ownershipTransfer': ownershipTransfer,
      'additionalTerms': additionalTerms,
    };
  }

  // Factory constructor to create a ContractInfo object from a Map
  factory ContractInfo.fromMap(Map<String, dynamic> map) {
    return ContractInfo(
      contractDate: map['contractDate'] ?? '',
      contractPlace: map['contractPlace'] ?? '',
      saleAmount: map['saleAmount'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      ownershipTransfer: map['ownershipTransfer'] ?? false,
      additionalTerms: map['additionalTerms'] ?? '',
    );
  }
}
