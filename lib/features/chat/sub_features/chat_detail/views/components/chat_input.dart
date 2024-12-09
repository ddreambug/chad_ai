import 'package:flutter/material.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/controllers/chat_detail_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/configs/themes/main_color.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ChatDetailController.to;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Input TextField
          Expanded(
            child: SizedBox(
              height: 50.w,
              child: TextField(
                focusNode: controller.textFieldFocus,
                style: CustomTextStyle.w500.copyWith(fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Ask Me Anything...',
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0).w,
                  hintStyle: CustomTextStyle.w500.copyWith(fontSize: 16.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    borderSide: BorderSide(
                      color: MainColor.borderStroke,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(60.r),
                    ),
                    borderSide: BorderSide(
                      color: MainColor.borderStroke,
                    ),
                  ),
                ),
                controller: controller.textController,
                onSubmitted: (value) {
                  controller.sendChatMessage(value);
                },
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // Send Button
          Obx(
            () {
              return SizedBox(
                height: 50.w,
                width: 50.w,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        strokeWidth: 3,
                        color: MainColor.purple,
                      )
                    : IconButton(
                        onPressed: () {
                          controller.sendChatMessage(
                            controller.textController.text,
                          );
                        },
                        icon: Iconify(
                          Cil.send,
                          color: MainColor.white,
                          size: 24.sp,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            MainColor.purple,
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
