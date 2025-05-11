import 'package:flutter_dotenv/flutter_dotenv.dart';

 //const _apiVersion = 'v1';
 //const base = 'http://192.168.100.7:8000/api/$_apiVersion';

final base = dotenv.env['BASE_API'] ?? '';

final registerEndPoint = '$base/register';
final loginEndPoint = '$base/login';
final logoutEndPoint = '$base/logout';
final userEndPoint = '$base/user';
final changePasswordEndPoint = '$userEndPoint/change-password';
