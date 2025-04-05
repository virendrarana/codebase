import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/error_retry_widget.dart';
import '../widgets/user_tile.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).fetchUsers(refresh: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50.h) {
        final provider = Provider.of<UserProvider>(context, listen: false);
        if (provider.hasMore && !provider.isLoading) {
          provider.fetchUsers();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Users')),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Consumer<UserProvider>(
                builder:
                    (context, userProvider, _) => CupertinoSearchTextField(
                      onChanged: userProvider.updateSearchQuery,
                      placeholder: 'Search by name...',
                    ),
              ),
            ),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, _) {
                  if (userProvider.errorMessage != null &&
                      userProvider.users.isEmpty) {
                    return ErrorRetryWidget(
                      errorMessage: userProvider.errorMessage!,
                      onRetry: () => userProvider.fetchUsers(refresh: true),
                    );
                  }
                  if (userProvider.users.isEmpty && userProvider.isLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return RefreshIndicator(
                    onRefresh: () => userProvider.fetchUsers(refresh: true),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                      itemCount: userProvider.users.length + 1,
                      itemBuilder: (context, index) {
                        if (index < userProvider.users.length) {
                          final user = userProvider.users[index];
                          return UserTile(
                            user: user,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/userDetail',
                                arguments: user,
                              );
                            },
                          );
                        } else {
                          return userProvider.isLoading
                              ? Padding(
                                padding: EdgeInsets.all(16.w),
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              )
                              : const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
