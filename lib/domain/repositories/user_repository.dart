import '../../data/models/user_response_model.dart';

abstract class UserRepository {
  Future<UserResponseModel> getUsers({int page, int perPage});
}


