List<PaymentStatusDetailsModel> paymentStatusDetailsModelObject = [];
class PaymentStatusDetailsModel {
  String id;
  String status;
  String paymentStatus;
  String paymentDate;
  String createdAt;
  String updatedAt;
  String brandingElementName;
  Map dimensions;
  List surveyImages;
  List installationImages;
  String installationDate;
  String ownerName;
  String countryCode;
  String mobileNumber;
  String shopName;
  String city;
  String locationImage;
  String cost;
  String paymentStatusLabel;

  PaymentStatusDetailsModel({
    required this.id,
    required this.status,
    required this.paymentStatus,
    required this.paymentDate,
    required this.createdAt,
    required this.updatedAt,
    required this.brandingElementName,
    required this.dimensions,
    required this.surveyImages,
    required this.installationImages,
    required this.installationDate,
    required this.ownerName,
    required this.countryCode,
    required this.mobileNumber,
    required this.shopName,
    required this.city,
    required this.locationImage,
    required this.cost,
    required this.paymentStatusLabel,
  });
}
