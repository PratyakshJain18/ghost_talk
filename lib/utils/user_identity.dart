import 'package:uuid/uuid.dart';

final String userId = const Uuid().v4();
final String username = "User_${userId.substring(0, 4)}";
final messageId = "${userId}_$username";