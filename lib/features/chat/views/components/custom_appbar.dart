import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/charm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.useLeading = false,
    this.useAction = false,
    this.onTap = _defaultOnTap,
    required this.title,
  });

  final String title;
  final bool useLeading;
  final bool useAction;
  final VoidCallback onTap;

  static void _defaultOnTap() {
    print("Default onTap triggered");
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainColor.primary,
      title: Text(
        title,
        style: CustomTextStyle.w500.copyWith(fontSize: 22.sp),
      ),
      centerTitle: true,
      leading: useLeading
          ? GestureDetector(
              onTap: () {
                ChatController.to.scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                child: Iconify(Charm.menu_hamburger),
              ),
            )
          : null,
      leadingWidth: 45.w,
      actions: useAction
          ? [
              IconButton(
                onPressed: onTap,
                icon: Iconify(
                  Carbon.overflow_menu_vertical,
                ),
              )
            ]
          : null,
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
