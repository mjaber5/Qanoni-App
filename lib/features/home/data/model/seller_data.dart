class Seller {
  final String fullName;
  final String birthDate;
  final String nationalID;
  final String registryNumber;
  final String registryPlace;
  final String expiryDate;

  Seller({
    required this.fullName,
    required this.birthDate,
    required this.nationalID,
    required this.registryNumber,
    required this.registryPlace,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'birthDate': birthDate,
      'nationalID': nationalID,
      'registryNumber': registryNumber,
      'registryPlace': registryPlace,
      'expiryDate': expiryDate,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      fullName: map['fullName'] ?? '',
      birthDate: map['birthDate'] ?? '',
      nationalID: map['nationalID'] ?? '',
      registryNumber: map['registryNumber'] ?? '',
      registryPlace: map['registryPlace'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
    );
  }
}
