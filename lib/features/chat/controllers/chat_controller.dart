import 'package:chad_ai/features/chat/repositories/chat_repositories.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:chad_ai/utils/services/sentry_service.dart';
import 'package:chad_ai/utils/services/utility_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  var arguments = Get.arguments;

  late final GenerativeModel model;
  var chatList = Rx<List<Map<String, dynamic>>>([]);
  var archivedChat = Rx<List<Map<String, dynamic>>>([]);
  late final String currentUserId;
  late final String currentName;
  late final int currentPin;
  late final bool currentIsGoogle;
  late final String currentEmail;
  late final String currentPassword;
  late final String currentAvatar;

  TextEditingController feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    currentUserId = arguments['userId'];
    currentName = arguments['name'];
    currentPin = arguments['pin'];
    currentIsGoogle = arguments['isGoogle'];
    currentEmail = arguments['email'];
    currentPassword = arguments['password'];
    currentAvatar = arguments['avatar'];

    getChats();
    updateArchivedChat();
  }

  //Get
  void getChats() {
    var chats = HiveService.getChats(email: currentEmail);

    chatList.value = List<Map<String, dynamic>>.from(chats);
    chatList.refresh();
  }

  // Api Post
  void apiSaveChat(int index) async {
    Get.back();
    EasyLoading.show();
    var chatData = chatList.value[index];
    var splittedChat = splitChatSession(chatData['data']);

    try {
      var response = await ChatRepositories().addChat(
        userId: currentUserId,
        chatId: chatData['id'],
        date: chatData['time'],
        chatSession: splittedChat,
      );

      if (response.statusCode == 201) {
        updateArchivedChat();
        deleteChat(index, archived: true);
      }
      EasyLoading.dismiss();
    } catch (e, stacktrace) {
      EasyLoading.dismiss();

      SentryService.handleAuthError(e, stacktrace);
    }
  }

  // Api Delete
  void apiDeleteChat(int index) async {
    try {
      Get.back();
      EasyLoading.show();
      var response = await ChatRepositories().deleteChat(
        userId: currentUserId,
        chatId: archivedChat.value[index]['id'],
      );

      if (response.statusCode == 200) {
        await updateArchivedChat();
        if (ChatController.to.archivedChat.value.isEmpty) {
          ChatController.to.viewType.value = ViewType.allChat;
          ChatController.to.appbarTitle.value = 'All Chat';
        }
        EasyLoading.dismiss();

        Get.showSnackbar(
          GetSnackBar(
            title: 'Chat Deleted',
            message: 'Chat Deleted from Database',
            duration: Duration(seconds: 1),
            snackPosition: SnackPosition.TOP,
          ),
        );
      } else {
        EasyLoading.dismiss();

        SentryService.handleAuthError('chat not found', StackTrace.current);
      }
    } catch (e, stacktrace) {
      SentryService.handleAuthError(e, stacktrace);
    }
  }

  //Delete
  void deleteChat(int index, {bool archived = false}) {
    HiveService.deleteChat(
      email: ChatController.to.currentEmail,
      chatIndex: index,
    );
    ChatController.to.getChats();

    if (!archived) {
      Get.back();
    }
    Get.showSnackbar(
      GetSnackBar(
        title: archived ? 'Chat Archived' : 'Chat Deleted',
        message:
            archived ? 'Chat Succesfully Archived' : 'Chat Succesfully Deleted',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  List<Map<String, dynamic>> splitChatSession(ChatSession chatSession) {
    List<Map<String, dynamic>> extractedText = [];

    for (var i = 0; i < chatSession.history.length; i++) {
      var data = UtilityService.extractMessageText(
        chatSession,
        i,
        ChatDataType.text,
      );
      var role = UtilityService.extractMessageText(
        chatSession,
        i,
        ChatDataType.role,
      );

      extractedText.add(
        {
          'data': data,
          'role': role,
        },
      );
    }

    return extractedText;
  }

  Future<void> updateArchivedChat() async {
    try {
      var response = await ChatRepositories().getArchivedChat(
        userId: currentUserId,
      );

      if (response.statusCode == 200) {
        archivedChat.value = List<Map<String, dynamic>>.from(response.data);
        archivedChat.refresh();
      }
    } catch (e) {
      print(e);
    }
  }

  void postFeedback() async {
    EasyLoading.show();
    var response = await ChatRepositories().sendFeedback(
      userId: currentUserId,
      name: currentName,
      date: DateFormat('dd/MM/yyyy HH:mm:ss', 'id_ID').format(DateTime.now()),
      feedback: feedbackController.text,
    );

    if (response.statusCode == 201) {
      EasyLoading.dismiss();
      feedbackController.clear();
      Get.back();

      Get.showSnackbar(
        GetSnackBar(
          title: 'Feedback Sent',
          message: 'Thanks for your feedback!',
          duration: Duration(seconds: 1),
          snackPosition: SnackPosition.TOP,
        ),
      );
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Something Wrong!',
          message: 'Something Wrong!',
          duration: Duration(seconds: 1),
          snackPosition: SnackPosition.TOP,
        ),
      );
    }
  }

  //Sidebar
  Rx<ViewType> viewType = ViewType.allChat.obs;

  //Appbar
  RxString appbarTitle = 'All Chat'.obs;
}
