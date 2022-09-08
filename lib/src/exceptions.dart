// ignore_for_file: public_member_api_docs

/// Custom [InvalidFormatException] exception
class InvalidFormatException implements Exception {
  InvalidFormatException(this.cause);

  String cause;
}
