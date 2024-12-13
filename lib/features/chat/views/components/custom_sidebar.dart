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
import 'package:google_sign_in/google_sign_in.dart';
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
                      backgroundImage: NetworkImage(
                        ChatController.to.currentAvatar,
                      ),
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
              title: 'New Chat'.tr,
              onTap: () {
                Get.toNamed('/chat-details');
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.list,
              title: 'All Chat'.tr,
              onTap: () {
                ChatController.to.viewType.value = ViewType.allChat;
                ChatController.to.appbarTitle.value = 'All Chat'.tr;
                Get.back();
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            Obx(
              () {
                var controller = ChatController.to.archivedChat.value;

                return SidebarContent(
                  leadingIcon: Carbon.archive,
                  title: 'Archived Chat'.tr,
                  customColor:
                      controller.isNotEmpty ? MainColor.black : MainColor.grey,
                  disableOntap: controller.isNotEmpty ? false : true,
                  onTap: controller.isNotEmpty
                      ? () {
                          ChatController.to.viewType.value =
                              ViewType.archivedChat;
                          ChatController.to.appbarTitle.value =
                              'Archived Chat'.tr;
                          Get.back();
                        }
                      : () {},
                );
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.user,
              title: 'Profile'.tr,
              onTap: () {
                ChatController.to.viewType.value = ViewType.profile;
                ChatController.to.appbarTitle.value = 'Profile & Settings'.tr;
                Get.back();
              },
            ),
            const Divider(indent: 20, endIndent: 25),
            SidebarContent(
              leadingIcon: Carbon.logout,
              title: 'Logout'.tr,
              customColor: MainColor.danger,
              onTap: () async {
                EasyLoading.show();
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
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
