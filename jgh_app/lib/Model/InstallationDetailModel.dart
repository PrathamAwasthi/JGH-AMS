InstallationDetailModel? installationDetailModelObject;
class InstallationDetailModel {
  String id;
  String status;
  String createdAt;
  String updatedAt;
  String brandingElementName;
  Map dimensions;
  List surveyImages;
  String ownerName;
  String countryCode;
  String mobileNumber;
  String shopName;
  String city;
  String locationImage;
  String cost;
  String quantity;
  String canUpload;
  String statusLabel;

  InstallationDetailModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.brandingElementName,
    required this.dimensions,
    required this.surveyImages,
    required this.ownerName,
    required this.countryCode,
    required this.mobileNumber,
    required this.shopName,
    required this.city,
    required this.locationImage,
    required this.cost,
    required this.quantity,
    required this.canUpload,
    required this.statusLabel,
  });
}

