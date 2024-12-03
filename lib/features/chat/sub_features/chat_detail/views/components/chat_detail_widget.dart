import 'package:chad_ai/features/chat/sub_features/chat_detail/controllers/chat_detail_controller.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/components/chat_input.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/utility_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/components/chat_detail_item.dart';

class ChatDetailWidget extends StatelessWidget {
  const ChatDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ChatDetailController.to;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.chat.value!.history.length,
                  itemBuilder: (context, idx) {
                    ChatSession data = ChatDetailController.to.chat.value!;

                    final text = UtilityService.extractMessageText(
                      data,
                      idx,
                      ChatDataType.text,
                    );
                    final role = UtilityService.extractMessageText(
                      data,
                      idx,
                      ChatDataType.role,
                    );

                    return GestureDetector(
                      onTap: () {
                        controller.textFieldFocus.unfocus();
                      },
                      child: ChatDetailItem(
                        text: text,
                        isFromUser: role == 'user',
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // User input
          ChatInput(),
        ],
      ),
    );
  }
}
