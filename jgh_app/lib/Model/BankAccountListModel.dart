List<BankAccountListModel> bankAccountListModelObjects = [];
class BankAccountListModel {
  String id;
  String vendorId;
  String bankName;
  String accountHolderName;
  String accountNumber;
  String ifscCode;
  String upiId;
  String isPrimary;
  String createdAt;
  String updatedAt;
  String deletedAt;

  BankAccountListModel({
    required this.id,
    required this.vendorId,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiId,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

}
