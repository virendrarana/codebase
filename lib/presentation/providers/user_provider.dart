import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_response.dart';
import '../../domain/usecases/get_users_use_case.dart';

class UserProvider with ChangeNotifier {
  final GetUsersUseCase getUsersUseCase;
  final Box _userBox;

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _page = 1;
  int _totalPages = 1;
  String _searchQuery = '';

  UserProvider({required this.getUsersUseCase, required Box userBox})
    : _userBox = userBox {
    final cachedUsers = _userBox.get('userBox');
    if (cachedUsers != null) {
      _users = List<User>.from(
        (cachedUsers as List).map(
          (json) => User.fromJson(Map<String, dynamic>.from(json)),
        ),
      );
    }
  }

  List<User> get users {
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
      final UserResponse response = await getUsersUseCase.call(
        page: _page,
        perPage: perPage,
      );
      _totalPages = response.totalPages;

      await Future.delayed(const Duration(seconds: 1));

      _users.addAll(response.data);
      _page++;

      final userJsonList = _users.map((user) => user.toJson()).toList();
      await _userBox.put('userBox', userJsonList);

    } catch (e) {
      _errorMessage = e.toString();
      final cachedUsers = _userBox.get('userBox');
      if (cachedUsers != null) {
        _users = List<User>.from(
          (cachedUsers as List).map(
            (json) => User.fromJson(Map<String, dynamic>.from(json)),
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cacheData() async {
    final cacheData = await _userBox.get('userBox');
    if (cacheData != null) {
      _users.addAll(
        List<User>.from(
          (cacheData as List).map(
            (json) => User.fromJson(Map<String, dynamic>.from(json)),
          ),
        ),
      );
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
