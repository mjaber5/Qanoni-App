// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarInfoForm {
  String carPlateNumber;
  String vinNumber;
  String engineNumber;
  String carModel;
  String carColor;
  String carRegistrationNumber;
  String insuranceExpiryDate;
  String carCondition;

  CarInfoForm({
    required this.carPlateNumber,
    required this.vinNumber,
    required this.engineNumber,
    required this.carModel,
    required this.carColor,
    required this.carRegistrationNumber,
    required this.insuranceExpiryDate,
    required this.carCondition,
  });

  Map<String, dynamic> toMap() {
    return {
      'carPlateNumber': carPlateNumber,
      'vinNumber': vinNumber,
      'engineNumber': engineNumber,
      'carModel': carModel,
      'carColor': carColor,
      'carRegistrationNumber': carRegistrationNumber,
      'insuranceExpiryDate': insuranceExpiryDate,
      'carCondition': carCondition,
    };
  }

  factory CarInfoForm.fromMap(Map<String, dynamic> map) {
    return CarInfoForm(
      carPlateNumber: map['carPlateNumber'] ?? '',
      vinNumber: map['vinNumber'] ?? '',
      engineNumber: map['engineNumber'] ?? '',
      carModel: map['carModel'] ?? '',
      carColor: map['carColor'] ?? '',
      carRegistrationNumber: map['carRegistrationNumber'] ?? '',
      insuranceExpiryDate: map['insuranceExpiryDate'] ?? '',
      carCondition: map['carCondition'] ?? '',
    );
  }
}
