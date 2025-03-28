import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/error_helper.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const ErrorRetryWidget({
    super.key,
    required this.onRetry,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final String friendlyMessage = ErrorHelper.getFriendlyErrorMessage(errorMessage);
    return Material(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                onPressed: onRetry,
                child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
