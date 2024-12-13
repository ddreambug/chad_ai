import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/icons/carbon.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.icon = Carbon.carbon,
    required this.ontap,
    this.color = MainColor.black,
    this.secondTitleColor = MainColor.black,
    this.secondTitle = '',
    this.description = '',
    this.isGoogle = false,
  });

  final String icon;
  final String title;
  final VoidCallback ontap;
  final Color color;
  final Color secondTitleColor;
  final String secondTitle;
  final String description;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MainColor.primary,
      child: InkWell(
        onTap: isGoogle ? null : ontap,
        child: SizedBox(
          height: description == '' ? 25 : 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.w500.copyWith(
                      color: color,
                      fontSize: 20.sp,
                    ),
                  ),
                  Spacer(),
                  if (secondTitle != '')
                    Text(
                      secondTitle,
                      style: CustomTextStyle.w400.copyWith(
                        color: secondTitleColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  if (icon != Carbon.carbon) ...{
                    SizedBox(width: 15.w),
                    Iconify(
                      icon,
                      size: 16.w,
                      color: color,
                    ),
                  }
                ],
              ),
              if (description != '') ...{
                SizedBox(height: 5.w),
                Text(
                  description,
                  style: CustomTextStyle.w400.copyWith(
                    color: MainColor.textGrey,
                    fontSize: 14.sp,
                    height: 0,
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
