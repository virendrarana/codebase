import 'user_model.dart';

class UserResponseModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> data;

  UserResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: List<UserModel>.from(
        json['data'].map((x) => UserModel.fromJson(x)),
      ),
    );
  }
}
