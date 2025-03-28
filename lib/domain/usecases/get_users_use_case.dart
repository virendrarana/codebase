import '../../data/models/user_response_model.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<UserResponseModel> call({int page = 1, int perPage = 10}) async {
    return await repository.getUsers(page: page, perPage: perPage);
  }
}
