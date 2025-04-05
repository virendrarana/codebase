import '../../data/models/user_response_model.dart';
import '../entities/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> getUsers({int page, int perPage});
}
