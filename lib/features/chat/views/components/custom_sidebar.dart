import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/chat/views/components/sidebar_content.dart';
import 'package:chad_ai/shared/widgets/app_info.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/carbon.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30).w,
        child: Column(
          children: [
            SizedBox(
              height: 220.w,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: MainColor.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30).w,
                  child: Center(
                    child: CircleAvatar(
                      radius: 50.r,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.w,
            ),
            SidebarContent(
              leadingIcon: Carbon.new_tab,
              title: 'New Chat',
              onTap: () {
                Get.toNamed('/chat-details');
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.list,
              title: 'All Chat',
              onTap: () {
                ChatController.to.viewType.value = ViewType.allChat;
                ChatController.to.appbarTitle.value = 'All Chat';
                Get.back();
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.archive,
              title: 'Achived Chat',
              onTap: () {
                ChatController.to.viewType.value = ViewType.archivedChat;
                ChatController.to.appbarTitle.value = 'Archived Chat';
                Get.back();
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.user,
              title: 'Profile',
              onTap: () {
                ChatController.to.viewType.value = ViewType.profile;
                ChatController.to.appbarTitle.value = 'Profile & Settings';
                Get.back();
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.logout,
              title: 'Logout',
              onTap: () async {
                EasyLoading.show();
                await FirebaseAuth.instance.signOut();
                EasyLoading.dismiss();
                Get.offAllNamed('/login');
              },
            ),
            Spacer(),
            AppInfo(showVersion: true),
          ],
        ),
      ),
    );
  }
}
