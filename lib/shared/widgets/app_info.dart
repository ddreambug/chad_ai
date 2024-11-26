import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/global_controllers/global_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({
    super.key,
    this.showVersion = false,
  });

  final bool showVersion;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 61.w,
      width: 193.w,
      child: Column(
        children: [
          if (showVersion) ...{
            Text(
              'Chad Ai - Version 1.0.0',
              style: CustomTextStyle.w500.copyWith(
                fontSize: 14.sp,
                color: MainColor.textGrey,
              ),
            ),
          },
          Text(
            'Powered by Gemini',
            style: CustomTextStyle.w500.copyWith(
              fontSize: 14.sp,
              color: MainColor.textGrey,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  GlobalController.to.webView(termsOfUse: true);
                },
                child: Text(
                  'Terms of Use',
                  style: CustomTextStyle.w600.copyWith(
                    fontSize: 14.sp,
                    color: MainColor.black,
                    letterSpacing: -0.8,
                  ),
                ),
              ),
              Text(
                '    |    ',
                style: CustomTextStyle.w500.copyWith(
                  fontSize: 14.sp,
                  color: MainColor.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  GlobalController.to.webView();
                },
                child: Text(
                  'Privacy Policy',
                  style: CustomTextStyle.w600.copyWith(
                    fontSize: 14.sp,
                    color: MainColor.black,
                    letterSpacing: -0.8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
