import 'package:codebase_assignment/domain/entities/user.dart';

class UserResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<User> data;

  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });
}
