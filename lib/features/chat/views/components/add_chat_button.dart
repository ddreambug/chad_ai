import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddChatButton extends StatelessWidget {
  const AddChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 45.w,
        child: TextButton.icon(
          onPressed: () {
            Get.toNamed("/chat-details");
          },
          label: Text(
            'Add New Chat',
            style: CustomTextStyle.w400.copyWith(
              fontSize: 16.sp,
              color: MainColor.black,
            ),
          ),
          icon: Iconify(
            Carbon.new_tab,
            size: 12,
          ),
        ),
      ),
    );
  }
}
