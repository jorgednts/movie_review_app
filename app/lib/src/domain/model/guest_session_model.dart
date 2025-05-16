class GuestSessionModel {
  final bool success;
  final String guestSessionId;
  final String expiresAt;

  GuestSessionModel({
    required this.success,
    required this.guestSessionId,
    required this.expiresAt,
  });
}
