import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> execute({int page = 1, int perPage = 10}) {
    return repository.fetchUsers(page: page, perPage: perPage);
  }
}
