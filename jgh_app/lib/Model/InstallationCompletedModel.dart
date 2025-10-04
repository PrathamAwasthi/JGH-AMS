List<InstallationCompletedModel> installationCompletedModelObject = [];
class InstallationCompletedModel {
  String id;
  String status;
  String createdAt;
  String updatedAt;
  String brandingElementName;
  Map dimensions;
  String ownerName;
  String shopName;
  String statusLabel;
  String cost;
  static String count = "0";

  InstallationCompletedModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.brandingElementName,
    required this.dimensions,
    required this.ownerName,
    required this.shopName,
    required this.statusLabel,
    required this.cost,
  });

}
