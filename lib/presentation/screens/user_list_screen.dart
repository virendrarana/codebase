import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'user_detail_screen.dart';

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200.h &&
          userProvider.hasMore &&
          !userProvider.isLoading) {
        userProvider.fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildUserTile(user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => UserDetailScreen(user: user),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.2),
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: CupertinoColors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  CupertinoIcons.forward,
                  size: 20.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(UserProvider userProvider) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: CupertinoSearchTextField(
        onChanged: userProvider.updateSearchQuery,
        placeholder: 'Search by name...',
      ),
    );
  }

  Widget _buildErrorWidget(UserProvider userProvider) {
    final String friendlyMessage = _getFriendlyErrorMessage(
      userProvider.errorMessage,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              friendlyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: CupertinoColors.systemRed,
              ),
            ),
            SizedBox(height: 20.h),
            CupertinoButton.filled(
              child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
              onPressed: () async {
                await userProvider.fetchUsers(refresh: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getFriendlyErrorMessage(String? error) {
    if (error == null || error.isEmpty) {
      return 'Something went wrong. Please try again.';
    }
    final lowerCaseError = error.toLowerCase();
    if (lowerCaseError.contains('socket') ||
        lowerCaseError.contains('no internet') ||
        lowerCaseError.contains('failed host lookup')) {
      return 'No internet connection. Please check your connection and try again.';
    }
    return 'Something went wrong. Please try again later.';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Users')),
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              _buildSearchBar(userProvider),
              Expanded(
                child:
                    userProvider.errorMessage != null &&
                            userProvider.users.isEmpty
                        ? _buildErrorWidget(userProvider)
                        : RefreshIndicator(
                          child: Material(
                            color: Colors.transparent,
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                              itemCount: userProvider.users.length + 1,
                              itemBuilder: (context, index) {
                                if (index < userProvider.users.length) {
                                  return _buildUserTile(
                                    userProvider.users[index],
                                  );
                                } else if (userProvider.isLoading) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                          onRefresh: () async {
                            await userProvider.fetchUsers(refresh: true);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
