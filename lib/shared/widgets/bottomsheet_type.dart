import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_bottom_sheet.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:chad_ai/shared/widgets/custom_text_buttom.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomsheetType {
  const BottomsheetType._();

  // Static method to return a list of reusable widgets
  static Widget allChat({
    required VoidCallback onArchive,
    required VoidCallback onDelete,
  }) {
    return CustomBottomSheet(
      title: 'Chat Settings',
      initSize: 0.45,
      widget: Column(
        children: [
          CustomTextButtom(
            title: 'Archive Chat',
            icon: Carbon.archive,
            ontap: onArchive,
          ),
          Divider(),
          CustomTextButtom(
            title: 'Delete Chat',
            icon: Carbon.trash_can,
            ontap: onDelete,
            color: MainColor.danger,
          ),
        ],
      ),
    );
  }

  static Widget archivedChat({
    required VoidCallback onDelete,
  }) {
    return CustomBottomSheet(
      title: 'Chat Settings',
      initSize: 0.35,
      widget: Column(
        children: [
          InkWell(
            onTap: onDelete,
            child: Row(
              children: [
                Text(
                  'Delete Chat',
                  style: CustomTextStyle.w500.copyWith(
                    color: MainColor.danger,
                  ),
                ),
                Spacer(),
                Iconify(
                  Carbon.trash_can,
                  size: 20.w,
                  color: MainColor.danger,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget changeName() {
    var formKey = GlobalKey<FormState>();
    return CustomBottomSheet(
      title: 'Change Nickname',
      initSize: 0.5,
      widget: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: ChatController.to.newNameController,
              hintText: 'New Nickname',
              isProfileEdit: true,
              customHeight: 40,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your new nickname';
                }
                return null;
              },
            ),
            SizedBox(height: 20.w),
            //button
            SizedBox(
              width: 340.w,
              child: Row(
                children: [
                  CustomButton(
                    onPress: () {
                      Get.back();
                      ChatController.to.newNameController.clear();
                    },
                    title: 'Cancel',
                    buttonWidth: 160,
                    buttonHeight: 50,
                  ),
                  Spacer(),
                  CustomButton(
                    onPress: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await ChatController.to.apiUpdateName();
                        ChatController.to.newNameController.clear();
                      }
                    },
                    title: 'Send',
                    buttonWidth: 160,
                    buttonHeight: 50,
                    buttonColor: MainColor.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget sendFeedback() {
    var formKey = GlobalKey<FormState>();
    return CustomBottomSheet(
      title: 'Feedback',
      initSize: 0.63,
      widget: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: ChatController.to.feedbackController,
              hintText: 'Enter your feedback here...',
              isProfileEdit: true,
              customHeight: 100,
              isArea: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
            ),
            SizedBox(height: 20.w),
            //button
            SizedBox(
              width: 340.w,
              child: Row(
                children: [
                  CustomButton(
                    onPress: () {
                      Get.back();
                      ChatController.to.feedbackController.clear();
                    },
                    title: 'Cancel',
                    buttonWidth: 160,
                    buttonHeight: 50,
                  ),
                  Spacer(),
                  CustomButton(
                    onPress: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ChatController.to.postFeedback();
                      }
                    },
                    title: 'Send',
                    buttonWidth: 160,
                    buttonHeight: 50,
                    buttonColor: MainColor.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget changeSecurity({required SecurityType securityType}) {
    var formKey = GlobalKey<FormState>();
    String title = securityType == SecurityType.pin ? 'Pin' : 'Password';
    return CustomBottomSheet(
      title: 'Change $title',
      initSize: 0.75,
      widget: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: ChatController.to.securityController,
              hintText: 'Current $title',
              obscureType: 'current',
              isProfileEdit: true,
              customHeight: 40,
              validator: (value) {
                var currentSecurity = title == 'Password'
                    ? ChatController.to.currentPassword
                    : ChatController.to.currentPin.toString();

                if (value == null || value.isEmpty) {
                  return 'Enter your current $title';
                } else if (value != currentSecurity) {
                  return '$title Mismatch, Please Recheck';
                }
                return null;
              },
            ),
            SizedBox(height: 10.w),
            CustomTextField(
              controller: ChatController.to.newSecurityController,
              hintText: 'New $title',
              obscureType: 'new',
              isProfileEdit: true,
              customHeight: 40,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your new $title';
                } else if (title == 'Pin') {
                  if (!RegExp(r"^\d{4}$").hasMatch(value) ||
                      value.length != 4) {
                    return 'PIN must be a 4-digit number';
                  }
                } else if (title == 'Password') {
                  if (value.length < 8) {
                    return 'New password minimum is 8 Character';
                  }
                }

                return null;
              },
            ),
            SizedBox(height: 10.w),

            CustomTextField(
              controller: ChatController.to.retypeNewSecurityController,
              hintText: 'Retype New $title',
              obscureType: 'retypeNew',
              isProfileEdit: true,
              customHeight: 40,
              validator: (value) {
                if (title == 'Password' &&
                    value != ChatController.to.newSecurityController.text) {
                  return 'Password didnt match';
                } else if (title == 'Pin' &&
                    value != ChatController.to.newSecurityController.text) {
                  return 'Pin didnt match';
                }
                return null;
              },
            ),
            SizedBox(height: 30.w),
            //button
            SizedBox(
              width: 340.w,
              child: Row(
                children: [
                  CustomButton(
                    onPress: () {
                      Get.back();
                      ChatController.to.securityController.clear();
                      ChatController.to.newSecurityController.clear();
                      ChatController.to.retypeNewSecurityController.clear();
                    },
                    title: 'Cancel',
                    buttonWidth: 160,
                    buttonHeight: 50,
                  ),
                  Spacer(),
                  CustomButton(
                    onPress: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await ChatController.to.apiUpdateSecurity(
                          isPin: title == 'Password' ? false : true,
                        );

                        ChatController.to.securityController.clear();
                        ChatController.to.newSecurityController.clear();
                        ChatController.to.retypeNewSecurityController.clear();
                      }
                    },
                    title: 'Send',
                    buttonWidth: 160,
                    buttonHeight: 50,
                    buttonColor: MainColor.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
