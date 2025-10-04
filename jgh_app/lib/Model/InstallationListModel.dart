List<InstallationListModel> installationListModelObject = [];
class InstallationListModel {
  String id;
  String status;
  String createdAt;
  String updatedAt;
  String brandingElementName;
  Map dimensions;
  List surveyImages;
  String ownerName;
  String shopName;
  String statusLabel;
  String cost;

  InstallationListModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.brandingElementName,
    required this.dimensions,
    required this.surveyImages,
    required this.ownerName,
    required this.shopName,
    required this.statusLabel,
    required this.cost,
  });
}




