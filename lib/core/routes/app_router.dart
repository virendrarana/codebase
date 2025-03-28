import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';
import '../../presentation/screens/user_detail_screen.dart';
import '../../presentation/screens/user_list_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => const UserListScreen(),
        );

      case '/userDetail':
        final user = settings.arguments as User;
        return CupertinoPageRoute(
          builder: (_) => UserDetailScreen(user: user),
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found!')),
          ),
        );
    }
  }
}
