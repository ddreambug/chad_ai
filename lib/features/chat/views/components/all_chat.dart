import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/chat/views/components/add_chat_button.dart';
import 'package:chad_ai/features/chat/views/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllChat extends StatelessWidget {
  const AllChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var data = ChatController.to.chatList.value;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15).w,
          child: ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (context, idx) {
              // Create add chat button
              if (idx == data.length) {
                return AddChatButton();
              }

              // Create chat card
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/chat-details',
                    arguments: {
                      'index': idx,
                      'data': data[idx]['data'],
                    },
                  );
                },
                child: ChatCard(idx: idx),
              );
            },
          ),
        );
      },
    );
  }
}
