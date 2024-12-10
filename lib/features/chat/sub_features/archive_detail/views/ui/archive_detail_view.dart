import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/chat/sub_features/archive_detail/controllers/archive_detail_controller.dart';
import 'package:chad_ai/features/chat/sub_features/archive_detail/views/components/archive_detail_widget.dart';
import 'package:chad_ai/features/chat/views/components/custom_appbar.dart';
import 'package:chad_ai/shared/widgets/bottomsheet_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveDetailView extends StatelessWidget {
  const ArchiveDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var idx = ArchiveDetailController.to.archiveIndex;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Archived Chat Details ',
        useAction: true,
        onTap: () {
          Get.bottomSheet(BottomsheetType.archivedChat(
            onDelete: () {
              ChatController.to.apiDeleteChat(idx);
              Get.back();
            },
          ));
        },
      ),
      body: Container(
        decoration: BoxDecoration(color: MainColor.primary),
        child: Center(
          child: ArchiveDetailWidget(),
        ),
      ),
    );
  }
}
