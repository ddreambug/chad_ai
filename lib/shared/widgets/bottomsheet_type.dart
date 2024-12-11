import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_bottom_sheet.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:chad_ai/shared/widgets/custom_text_buttom.dart';
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

  static Widget sendFeedback({
    required VoidCallback onDelete,
  }) {
    var formKey = GlobalKey<FormState>();
    return CustomBottomSheet(
      title: 'Feedback',
      initSize: 0.65,
      widget: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: ChatController.to.feedbackController,
              maxLines: 3,
              minLines: 1,
              cursorHeight: 15,
              keyboardType: TextInputType.multiline,
              style: CustomTextStyle.w400.copyWith(fontSize: 18.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                hintText: 'Enter your feedback here...',
                hintStyle: CustomTextStyle.w400.copyWith(
                  fontSize: 18.sp,
                  color: MainColor.textGrey,
                ),
              ),
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
}
