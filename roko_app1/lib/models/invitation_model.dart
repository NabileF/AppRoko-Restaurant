class InvitationModel {
  String invitationId;
  String supplierId;
  int phoneNumber;
  String email;
  String status;
  DateTime createdAt;

  InvitationModel({
    required this.invitationId,
    required this.supplierId,
    required this.phoneNumber,
    required this.email,
    required this.status,
    required this.createdAt,
  });
}
