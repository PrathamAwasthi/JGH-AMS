List<SurveyListModel> surveyListModelObjects = [];
class SurveyListModel {
  String? userId;
  String? latestUpdatedAt;
  String? createdAt;
  String? ownerName;
  String? countryCode;
  String? mobileNumber;
  String? shopName;
  String? locationImage;
  String? city;
  String? stateName;
  String? address;
  String? pincode;
  String? brandingElements;
  String? statusLabel;
  String? latitude;
  String? longitude;
  SurveyListModel({
    required this.userId,
    required this.latestUpdatedAt,
    required this.createdAt,
    required this.ownerName,
    required this.countryCode,
    required this.mobileNumber,
    required this.shopName,
    required this.locationImage,
    required this.city,
    required this.stateName,
    required this.address,
    required this.pincode,
    required this.brandingElements,
    required this.statusLabel,
    required this.latitude,
    required this.longitude,
});
}