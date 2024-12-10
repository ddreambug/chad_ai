import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/sub_features/archive_detail/controllers/archive_detail_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/components/chat_detail_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 5.w, bottom: 10.w),
              width: 350.w,
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                'Currently you can only see your chat history, stay tunes for further updates',
                textAlign: TextAlign.center,
                style: CustomTextStyle.w400.copyWith(
                  color: MainColor.textGrey,
                  fontSize: 12,
                ),
              ),
            ),
          ),

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
