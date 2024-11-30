import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/views/components/chat_item.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ChatController.to;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView to display chat history
          Expanded(
            child: Obx(() {
              final history =
                  ChatController.to.chat.value?.history.toList() ?? [];
                  
              return ListView.builder(
                controller: controller.scrollController,
                itemBuilder: (context, idx) {
                  final content = history[idx];
                  final text = content.parts
                      .whereType<TextPart>()
                      .map<String>((e) => e.text)
                      .join('');
                  return GestureDetector(
                    onTap: () {
                      controller.textFieldFocus.unfocus();
                    },
                    child: ChatItem(
                      text: text,
                      isFromUser: content.role == 'user',
                    ),
                  );
                },
                itemCount: controller.chat.value!.history.length,
              );
            }),
          ),

          // Input and Send Button Row
          Padding(
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
                        hintStyle:
                            CustomTextStyle.w500.copyWith(fontSize: 16.sp),
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

                // Send Button or Loading Indicator
                Obx(() {
                  return SizedBox(
                    height: 50.w,
                    width: 50.w,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              controller.sendChatMessage(
                                  controller.textController.text);
                            },
                            icon: Iconify(
                              Cil.send,
                              color: MainColor.white,
                              size: 24.sp,
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(MainColor.purple),
                            ),
                          ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
