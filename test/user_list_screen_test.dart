/*import 'package:codebase_assignment/domain/entities/user.dart';
import 'package:codebase_assignment/domain/usecases/get_users_use_case.dart';
import 'package:codebase_assignment/domain/repositories/user_repository.dart';
import 'package:codebase_assignment/presentation/providers/user_provider.dart';
import 'package:codebase_assignment/presentation/screens/user_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<List<User>> fetchUsers({int page = 1, int perPage = 10}) async {
    return [];
  }
}

class DummyGetUsers extends GetUsersUseCase {
  DummyGetUsers() : super(DummyUserRepository());
}

class FakeUserProvider extends ChangeNotifier implements UserProvider {
  final List<User> _users = [
    User(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      avatar: 'https://example.com/avatar.png',
    ),
  ];

  @override
  List<User> get users => _users;

  @override
  bool get hasMore => false;

  @override
  bool get isLoading => false;

  @override
  Future<void> fetchUsers({bool refresh = false}) async {
    // No-op for testing.
  }

  @override
  void updateSearchQuery(String query) {
    // No-op for testing.
  }

  @override
  String? get errorMessage => null;

  @override
  GetUsersUseCase get getUsers => DummyGetUsers();
}

void main() {
  group('UserListScreen Widget Tests', () {
    testWidgets('renders search bar and list tiles', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                create: (_) => FakeUserProvider(),
              ),
            ],
            child: ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (context, child) => MaterialApp(
                home: child,
              ),
              child: const UserListScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(CupertinoSearchTextField), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('john.doe@example.com'), findsOneWidget);
      });
    });

    testWidgets('navigates to detail screen on tap', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                create: (_) => FakeUserProvider(),
              ),
            ],
            child: ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (context, child) => MaterialApp(
                home: child,
              ),
              child: const UserListScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('John Doe'));
        await tester.pumpAndSettle();

        expect(find.byType(UserListScreen), findsNothing);
      });
    });
  });
}*/
