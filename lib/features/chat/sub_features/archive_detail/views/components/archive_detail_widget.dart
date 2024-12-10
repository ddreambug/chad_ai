import 'package:chad_ai/features/chat/sub_features/archive_detail/controllers/archive_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/components/chat_detail_item.dart';

class ArchiveDetailWidget extends StatelessWidget {
  const ArchiveDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = ArchiveDetailController.to;

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
                  itemCount: controller.archivedChat.value.length,
                  itemBuilder: (context, idx) {
                    Map<String, dynamic> data =
                        ArchiveDetailController.to.archivedChat.value[idx];

                    return ChatDetailItem(
                      text: data['data'],
                      isFromUser: data['role'] == 'user',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
