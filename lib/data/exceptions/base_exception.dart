 class BaseException implements Exception {
  final String? message;
  final Map<String, dynamic>? errors;
  const BaseException({this.message = 'Unexpected Error', this.errors});

  @override
  String toString() {
    return message ?? 'unexpected error';
  }
}


