import 'package:codebase_assignment/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.onTap, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
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
              Hero(
                tag: 'avatar_${user.id}',
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
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
}
