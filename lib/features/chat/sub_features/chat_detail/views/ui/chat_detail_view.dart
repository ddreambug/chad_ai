import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/controllers/chat_detail_controller.dart';
import 'package:chad_ai/features/chat/sub_features/chat_detail/views/components/chat_detail_widget.dart';
import 'package:chad_ai/features/chat/views/components/custom_appbar.dart';
import 'package:chad_ai/shared/widgets/bottomsheet_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Chat Details',
        useAction: true,
        onTap: () {
          Get.bottomSheet(BottomsheetType.allChat(
            onArchive: () {},
            onDelete: () {
              ChatDetailController.to.deleteChat();
            },
          ));
        },
      ),
      body: Container(
        decoration: BoxDecoration(color: MainColor.primary),
        child: Center(
          child: ChatDetailWidget(),
        ),
      ),
    );
  }
}
