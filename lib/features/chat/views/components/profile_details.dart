import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/app_info.dart';
import 'package:chad_ai/shared/widgets/bottomsheet_type.dart';
import 'package:chad_ai/shared/widgets/custom_text_button.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ChatController.to;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30).w,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(
                ChatController.to.currentAvatar,
              ),
            ),
            SizedBox(height: 10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.currentName.value,
                    style: CustomTextStyle.w600.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      isDismissible: false,
                      BottomsheetType.changeName(),
                    );
                  },
                  child: Iconify(
                    Ic.baseline_mode_edit,
                    color: MainColor.textGrey,
                    size: 22.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.w),
            CustomTextButton(
              title: 'Email'.tr,
              secondTitle: controller.currentEmail,
              secondTitleColor: MainColor.purple,
              ontap: () {},
            ),
            const Divider(),
            // CustomTextButton(
            //   title: 'Theme'.tr,
            //   secondTitle: ChatController.to.themeRadioValue.value == 1
            //       ? 'System default'.tr
            //       : ChatController.to.themeRadioValue.value == 2
            //           ? 'Light mode'.tr
            //           : 'Dark mode'.tr,
            //   ontap: () {},
            //   icon: Carbon.arrow_up_right,
            // ),
            // const Divider(),
            Obx(
              () {
                var currentLanguageValue =
                    ChatController.to.languageRadioValue.value;

                return CustomTextButton(
                  title: 'Language'.tr,
                  secondTitle: currentLanguageValue == 1
                      ? 'System default'.tr
                      : currentLanguageValue == 2
                          ? 'English'.tr
                          : 'Indonesia'.tr,
                  ontap: () {
                    Get.bottomSheet(
                      BottomsheetType.changeLanguage(),
                    );
                  },
                  icon: Carbon.arrow_up_right,
                );
              },
            ),
            const Divider(),
            CustomTextButton(
              title: 'Change Pin'.tr,
              ontap: () {
                Get.bottomSheet(
                  isDismissible: false,
                  BottomsheetType.changeSecurity(
                    securityType: SecurityType.pin,
                  ),
                );
              },
              icon: Carbon.arrow_up_right,
              isGoogle: ChatController.to.currentIsGoogle,
              color: ChatController.to.currentIsGoogle
                  ? MainColor.textGrey
                  : MainColor.black,
            ),
            const Divider(),
            CustomTextButton(
              title: 'Change Password'.tr,
              ontap: () {
                Get.bottomSheet(
                  isDismissible: false,
                  BottomsheetType.changeSecurity(
                    securityType: SecurityType.password,
                  ),
                );
              },
              icon: Carbon.arrow_up_right,
              isGoogle: ChatController.to.currentIsGoogle,
              color: ChatController.to.currentIsGoogle
                  ? MainColor.textGrey
                  : MainColor.black,
            ),
            const Divider(),
            CustomTextButton(
              title: 'Send Feedback'.tr,
              description:
                  'Chatbot AI can make mistakes. Consider checking important information and send us your feedback.'
                      .tr,
              ontap: () {
                Get.bottomSheet(
                  isDismissible: false,
                  BottomsheetType.sendFeedback(),
                );
              },
              icon: Carbon.arrow_up_right,
            ),
            Spacer(),
            AppInfo(showVersion: true),
          ],
        ),
      ),
    );
  }
}
