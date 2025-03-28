import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_users_use_case.dart';

class UserProvider with ChangeNotifier {
  final GetUsersUseCase getUsersUseCase;
  final Box _userBox;

  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _page = 1;
  int _totalPages = 1;
  String _searchQuery = '';

  UserProvider({required this.getUsersUseCase, required Box userBox})
      : _userBox = userBox {

    final cachedUsers = _userBox.get('userBox');
    if (cachedUsers != null) {
      _users = List<UserModel>.from(
        (cachedUsers as List).map(
              (json) => UserModel.fromJson(
            Map<String, dynamic>.from(json),
          ),
        ),
      );
    }
  }

  List<UserModel> get users {
    if (_searchQuery.isEmpty) {
      return _users;
    } else {
      return _users.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get hasMore => _page <= _totalPages;

  Future<void> fetchUsers({bool refresh = false, int perPage = 10}) async {
    if (refresh) {
      _page = 1;
      _users = [];
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response =
      await getUsersUseCase.call(page: _page, perPage: perPage);
      _totalPages = response.totalPages;
      await Future.delayed(Duration(seconds: 1));

      _users.addAll(response.data);
      _page++;

      final userJsonList = _users.map((user) => user.toJson()).toList();
      await _userBox.put('userBox', userJsonList);

    } catch (e) {
      _errorMessage = e.toString();
      final cachedUsers = _userBox.get('userBox');
      if (cachedUsers != null) {
        _users = List<UserModel>.from(
          (cachedUsers as List).map(
                (json) => UserModel.fromJson(
              Map<String, dynamic>.from(json),
            ),
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
