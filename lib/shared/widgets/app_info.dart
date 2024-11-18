import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.w,
      width: 193.w,
      child: Column(
        children: [
          Text(
            'Chad Ai - Version 1.0.0',
            style: CustomTextStyle.w500.copyWith(
              fontSize: 14.sp,
              color: MainColor.textGrey,
            ),
          ),
          Text(
            'Powered by Gemini',
            style: CustomTextStyle.w500.copyWith(
              fontSize: 14.sp,
              color: MainColor.textGrey,
            ),
          ),
          RichText(
            text: TextSpan(
              style: CustomTextStyle.w500.copyWith(
                fontSize: 14.sp,
                color: MainColor.textGrey,
              ),
              children: [
                TextSpan(
                  text: 'Terms of Use',
                ),
                TextSpan(
                  text: '   |   ',
                ),
                TextSpan(
                  text: 'Privacy policy',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
