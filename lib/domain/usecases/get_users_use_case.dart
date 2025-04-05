import '../../domain/entities/user_response.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<UserResponse> call({int page = 1, int perPage = 10}) async {
    return await repository.getUsers(page: page, perPage: perPage);
  }
}
