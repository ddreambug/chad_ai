import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Elevate and Improve your way of Thinking',
          style: CustomTextStyle.w600.copyWith(
            fontSize: 40.sp,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 40.w),
      ],
    );
  }
}
