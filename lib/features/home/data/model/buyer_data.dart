class Buyer {
  final String fullName;
  final String birthDate;
  final String nationalID;
  final String registryNumber;
  final String registryPlace;
  final String expiryDate;

  Buyer({
    required this.fullName,
    required this.birthDate,
    required this.nationalID,
    required this.registryNumber,
    required this.registryPlace,
    required this.expiryDate,
  });

  // Converts the Buyer instance into a map for easy integration with databases or APIs.
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

  // Factory constructor to create a Buyer instance from a map.
  factory Buyer.fromMap(Map<String, dynamic> map) {
    return Buyer(
      fullName: map['fullName'] ?? '',
      birthDate: map['birthDate'] ?? '',
      nationalID: map['nationalID'] ?? '',
      registryNumber: map['registryNumber'] ?? '',
      registryPlace: map['registryPlace'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
    );
  }
}
