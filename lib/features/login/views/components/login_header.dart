import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/utils/enums/enum.dart';
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
        GestureDetector(
          onTap: () {
            LoginController.to.showDialog(context, DialogType.signup);
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Don’t have an account? ',
                  style: CustomTextStyle.w500.copyWith(
                    color: MainColor.textGrey,
                    fontSize: 16.sp,
                  ),
                ),
                TextSpan(
                  text: 'Sign Up',
                  style: CustomTextStyle.w600.copyWith(
                    color: MainColor.textGrey,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
