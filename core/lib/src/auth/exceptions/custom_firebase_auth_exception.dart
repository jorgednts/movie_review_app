enum FirebaseAuthExceptionType {
  emailAlreadyInUse,
  weakPassword,
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  userTokenExpired,
  networkRequestFailed,
  operationNotAllowed,
  unknown;

  static FirebaseAuthExceptionType fromCode(String code) {
    switch (code.toLowerCase()) {
      case 'email-already-in-use':
        return FirebaseAuthExceptionType.emailAlreadyInUse;
      case 'invalid-email':
        return FirebaseAuthExceptionType.invalidEmail;
      case 'operation-not-allowed':
        return FirebaseAuthExceptionType.operationNotAllowed;
      case 'weak-password':
        return FirebaseAuthExceptionType.weakPassword;
      case 'too-many-requests':
        return FirebaseAuthExceptionType.tooManyRequests;
      case 'user-token-expired':
        return FirebaseAuthExceptionType.userTokenExpired;
      case 'network-request-failed':
        return FirebaseAuthExceptionType.networkRequestFailed;
      case 'user-disabled':
        return FirebaseAuthExceptionType.userDisabled;
      case 'user-not-found':
        return FirebaseAuthExceptionType.userNotFound;
      case 'wrong-password':
      case 'invalid_login_credentials':
      case 'invalid-credential':
        return FirebaseAuthExceptionType.wrongPassword;
      default:
        return FirebaseAuthExceptionType.unknown;
    }
  }
}

class CustomFirebaseAuthException implements Exception {
  final FirebaseAuthExceptionType type;

  CustomFirebaseAuthException({required this.type});

  factory CustomFirebaseAuthException.fromCode(String code) {
    return CustomFirebaseAuthException(
      type: FirebaseAuthExceptionType.fromCode(code),
    );
  }
}
