import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final Box userBox;

  UserRepositoryImpl({required this.remoteDataSource, required this.userBox});

  @override
  Future<List<User>> fetchUsers({int page = 1, int perPage = 10}) async {
    final cacheKey = 'users_page_$page';
    final timestampKey = 'users_page_${page}_timestamp';
    final cacheDuration = Duration(hours: 1);

    final cachedData = userBox.get(cacheKey);
    final cachedTimestamp = userBox.get(timestampKey);

    if (cachedData != null && cachedTimestamp != null) {
      final cachedTime = DateTime.tryParse(cachedTimestamp as String);
      if (cachedTime != null &&
          DateTime.now().difference(cachedTime) < cacheDuration) {
        return (cachedData as List)
            .map((json) => UserModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      }
    }

    final fetchedUsers = await remoteDataSource.fetchUsers(
      page: page,
      perPage: perPage,
    );

    if (fetchedUsers.isNotEmpty) {
      final List<Map<String, dynamic>> jsonList =
          fetchedUsers.map((user) => (user).toJson()).toList();
      await userBox.put(cacheKey, jsonList);
      await userBox.put(timestampKey, DateTime.now().toIso8601String());
    }

    return fetchedUsers;
  }
}
