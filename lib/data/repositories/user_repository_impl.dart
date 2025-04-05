import '../../domain/entities/user_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';
import '../models/user_response_model.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserResponse> getUsers({int page = 1, int perPage = 10}) async {
    try {
      final UserResponseModel userResponseModel = await remoteDataSource
          .fetchUsers(page: page, perPage: perPage);
      return UserResponse(
        page: userResponseModel.page,
        perPage: userResponseModel.perPage,
        total: userResponseModel.total,
        totalPages: userResponseModel.totalPages,
        data:
            userResponseModel.data
                .map(
                  (userModel) => User(
                    id: userModel.id,
                    email: userModel.email,
                    firstName: userModel.firstName,
                    lastName: userModel.lastName,
                    avatar: userModel.avatar,
                  ),
                )
                .toList(),
      );
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }
}
