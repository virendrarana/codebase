import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

class UserProvider extends ChangeNotifier {
  final GetUsers getUsers;

  List<User> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  String? _errorMessage;

  UserProvider({required this.getUsers});

  List<User> get users {
    if (_searchQuery.trim().isEmpty) return _users;
    final query = _searchQuery.trim().toLowerCase();
    return _users.where((user) {
      final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
      return fullName.contains(query);
    }).toList();
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;

    if (refresh) {
      _page = 1;
      _users.clear();
      _hasMore = true;
    }

    try {
      final fetchedUsers = await getUsers.execute(page: _page);
      if (fetchedUsers.isEmpty) {
        _hasMore = false;
      } else {
        _users.addAll(fetchedUsers);
        _page++;
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }
}
