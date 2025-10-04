class CreateTicket {
  String id;
  String userId;
  String title;
  String description;
  String status;
  String priority;
  String assignedTo;
  String createdAt;
  String updatedAt;
  String category;
  String generationSource;
  String belongsTo;
  String replies;
  List media;

  CreateTicket({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.assignedTo,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.generationSource,
    required this.belongsTo,
    required this.replies,
    required this.media,
  });
}