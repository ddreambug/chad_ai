import 'package:chad_ai/shared/widgets/bottomsheet_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/utility_service.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.idx,
  });

  final int idx;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(25, 98, 42, 116),
        borderRadius: BorderRadius.circular(20).r,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 230.w,
              child: Text(
                UtilityService.extractMessageText(
                  ChatController.to.hiveChat.value[idx]['data'],
                  0,
                  ChatDataType.text,
                ),
                style: CustomTextStyle.w500.copyWith(
                  fontSize: 16.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Text(
              DateFormat('dd/MM/yyyy').format(
                ChatController.to.hiveChat.value[idx]['time'],
              ),
              style: CustomTextStyle.w400.copyWith(
                fontSize: 14.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  BottomsheetType.allChat(
                    onArchive: () {},
                    onDelete: () {
                      ChatController.to.deleteChat(idx);
                    },
                  ),
                );
              },
              child: Iconify(Carbon.overflow_menu_vertical),
            ),
          ],
        ),
      ),
    );
  }
}
