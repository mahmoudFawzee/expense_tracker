 class User {
   final int? _id = null;
  final String firstName, lastName, phoneNumber, email;
  const User({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  int? get id => _id;
}