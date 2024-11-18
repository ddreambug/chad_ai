import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MainColor.grey,
            indent: 5.r,
            endIndent: 20.r,
          ),
        ),
        Text(
          'Or login with',
          style: CustomTextStyle.w400.copyWith(
            color: MainColor.textGrey,
            fontSize: 16.sp,
          ),
        ),
        Expanded(
          child: Divider(
            color: MainColor.grey,
            indent: 20.r,
            endIndent: 5.r,
          ),
        ),
      ],
    );
  }
}
