class User {
  final int? _id;
  final String firstName, lastName, phoneNumber, email;
  const User({
    int? id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  }) : _id = id;

  int? get id => _id;
}
