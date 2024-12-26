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
    this.carPlateNumber = '',
    this.vinNumber = '',
    this.engineNumber = '',
    this.carModel = '',
    this.carColor = '',
    this.carRegistrationNumber = '',
    this.insuranceExpiryDate = '',
    this.carCondition = '',
  });

  // You can add methods to update fields based on OCR data if needed.
  void updateFromOCR({
    String? plateNumber,
    String? vinNumber,
    String? engineNumber,
    String? carModel,
    String? carColor,
    String? registrationNumber,
    String? expiryDate,
    String? condition,
  }) {
    carPlateNumber = plateNumber ?? carPlateNumber;
    vinNumber = vinNumber ?? this.vinNumber;
    engineNumber = engineNumber ?? this.engineNumber;
    carModel = carModel ?? this.carModel;
    carColor = carColor ?? this.carColor;
    carRegistrationNumber = registrationNumber ?? carRegistrationNumber;
    insuranceExpiryDate = expiryDate ?? insuranceExpiryDate;
    carCondition = condition ?? carCondition;
  }
}
