import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/chat/views/components/all_chat.dart';
import 'package:chad_ai/features/chat/views/components/archived_chat.dart';
import 'package:chad_ai/features/chat/views/components/custom_appbar.dart';
import 'package:chad_ai/features/chat/views/components/custom_fab.dart';
import 'package:chad_ai/features/chat/views/components/custom_sidebar.dart';
import 'package:chad_ai/features/chat/views/components/profile_details.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppbar(),
      drawer: CustomSidebar(),
      floatingActionButton: CustomFab(),
      body: Container(
        decoration: BoxDecoration(color: MainColor.primary),
        child: Obx(
          () {
            var viewType = ChatController.to.viewType.value;

            if (viewType == ViewType.allChat) {
              return AllChat();
            } else if (viewType == ViewType.archivedChat) {
              return ArchivedChat();
            } else {
              return ProfileDetails();
            }
          },
        ),
      ),
    );
  }
}
