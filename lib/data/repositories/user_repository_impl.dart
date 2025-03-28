import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';
import '../models/user_response_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserResponseModel> getUsers({int page = 1, int perPage = 10}) async {
    try {
      return await remoteDataSource.fetchUsers(page: page, perPage: perPage);
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }
}