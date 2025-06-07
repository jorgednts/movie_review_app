class GuestSessionResponse {
  final bool success;
  final String guestSessionId;
  final String expiresAt;

  GuestSessionResponse({
    required this.success,
    required this.guestSessionId,
    required this.expiresAt,
  });

  factory GuestSessionResponse.fromJson(Map<String, dynamic> json) {
    return GuestSessionResponse(
      success: json['success'],
      guestSessionId: json['guest_session_id'],
      expiresAt: json['expires_at'],
    );
  }
}
