import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/charm.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        ),
        body: Container(
          decoration: BoxDecoration(color: MainColor.primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    Get.toNamed("/chat-details");
                  },
                  label: Text(
                    'Add New Chat',
                    style: CustomTextStyle.w400
                        .copyWith(fontSize: 16.sp, color: MainColor.black),
                  ),
                  icon: Iconify(
                    Carbon.new_tab,
                    size: 12,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
