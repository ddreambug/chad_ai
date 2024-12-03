import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed('/chat-details');
      },
      mini: true,
      backgroundColor: MainColor.purple,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Iconify(
        Carbon.new_tab,
        size: 16,
        color: MainColor.white,
      ),
    );
  }
}
