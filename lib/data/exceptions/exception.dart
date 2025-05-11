final class InternalServerException implements Exception {
  final String message;
  const InternalServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

final class UserException implements Exception {
  final String? message;
  const UserException([this.message = 'Unexpected Error']);

  @override
  String toString() {
    return message??'unexpected error';
  }
}
