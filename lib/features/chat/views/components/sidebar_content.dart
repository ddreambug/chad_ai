import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SidebarContent extends StatelessWidget {
  const SidebarContent({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  final String leadingIcon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          left: 25,
          right: 40,
        ).w,
        child: SizedBox(
          height: 45.w,
          child: Row(
            children: [
              Iconify(
                leadingIcon,
                size: 14.w,
                color: title == 'Logout' ? MainColor.danger : MainColor.black,
              ),
              SizedBox(width: 20.w),
              Text(
                title,
                style: CustomTextStyle.w500.copyWith(
                  fontSize: 21.sp,
                  color: title == 'Logout' ? MainColor.danger : MainColor.black,
                ),
              ),
              Spacer(),
              Iconify(
                Carbon.arrow_up_right,
                size: 16.w,
                color: title == 'Logout' ? MainColor.danger : MainColor.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
