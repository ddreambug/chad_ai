import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.iconifyIcon = '',
    this.hintText = '',
    this.needObscure = false,
  });

  final String iconifyIcon;
  final String hintText;
  final bool needObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: MainColor.textGrey.withAlpha(90)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Iconify(
              iconifyIcon,
              color: MainColor.textGrey,
              size: 28.w,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  hintStyle: CustomTextStyle.w500.copyWith(
                    fontSize: 16.sp,
                    color: MainColor.textGrey,
                  ),
                ),
                style: CustomTextStyle.w500.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            if (needObscure) ...{
              Iconify(
                Ri.eye_line,
                color: MainColor.purple,
                size: 28.w,
              )
            }
          ],
        ),
      ),
    );
  }
}
