import 'package:codebase_assignment/core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${user.firstName} ${user.lastName}'),
      ),
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: AppTheme().background,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'avatar_${user.id}',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: screenSize.width * 0.25,
                        backgroundImage: NetworkImage(user.avatar),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle
                      .copyWith(fontSize: 28.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  user.email,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 18.sp, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 290.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 12.h,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Go Back',
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
