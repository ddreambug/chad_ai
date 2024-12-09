import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/chat/views/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ArchivedChat extends StatelessWidget {
  const ArchivedChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MainColor.primary),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15).w,
        child: Obx(
          () {
            var data = ChatController.to.archivedChat.value;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, idx) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/chat-details',
                      arguments: {
                        'index': idx,
                        'data': data[idx]['data'],
                        'archived': true,
                      },
                    );
                  },
                  child: ChatCard(
                    idx: idx,
                    isArchived: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
