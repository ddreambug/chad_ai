import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainColor.primary,
      title: Text(
        'All Chat',
        style: CustomTextStyle.w500.copyWith(fontSize: 22.sp),
      ),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Iconify(Charm.menu_hamburger),
      ),
      leadingWidth: 45.w,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
