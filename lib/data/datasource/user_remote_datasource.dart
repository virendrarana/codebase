import 'dart:async';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers({int page = 1, int perPage = 10});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  final String baseUrl = 'https://reqres.in/api';

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> fetchUsers({int page = 1, int perPage = 10}) async {
    try {
      final response = await dio
          .get(
            '$baseUrl/users',
            queryParameters: {'page': page, 'per_page': perPage},
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out. Please try again.');
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }
}
