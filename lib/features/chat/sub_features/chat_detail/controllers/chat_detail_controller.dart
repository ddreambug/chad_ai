import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:chad_ai/utils/services/utility_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatDetailController extends GetxController {
  static ChatDetailController get to => Get.find();

  final arguments = Get.arguments;
  late final GenerativeModel model;
  var chat = Rx<ChatSession?>(null);
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  var savedChat = Rx<ChatSession?>(null);
  var isLoading = false.obs;
  bool save = true;
  bool canArchive = false;

  final safetySetting = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
  ];

  @override
  void onInit() {
    super.onInit();
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCJ5l9efz2xqJF5W80HB47KTFZJPBfhfvc',
      safetySettings: safetySetting,
      generationConfig: GenerationConfig(temperature: 1.6),
    );
    chat.value = model.startChat();

    if (arguments != null) {
      chat.value = arguments['data'];
      canArchive = true;
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (chat.value != null && chat.value!.history.length >= 2 && save) {
      if (!compareChatData()) {
        ChatController.to.viewType.value = ViewType.allChat;
        var id = DateTime.now().millisecondsSinceEpoch;
        var time = DateTime.now();

        HiveService.saveChat(
          email: ChatController.to.currentEmail,
          id: id,
          time: time,
          session: chat.value!,
        );

        ChatController.to.getChats();
      }
    }
  }

  void deleteChat() {
    if (arguments != null) {
      int index = arguments['index'];
      HiveService.deleteChat(
        email: ChatController.to.currentEmail,
        chatIndex: index,
      );
      ChatController.to.getChats();
      backToAllChat();
    } else {
      backToAllChat();
    }
  }

  void archiveChat() {
    if (arguments != null) {
      int index = arguments['index'];
      ChatController.to.apiSaveChat(index);
      save = false;
      Get.back();
      Get.back();
    } else {
      Get.back();
      Get.back();
    }
  }

  void backToAllChat() {
    save = false;
    Get.back();
    Get.back();
    Get.showSnackbar(
      GetSnackBar(
        title: 'Chat Deleted',
        message: 'Chat Succesfully Deleted',
        duration: Duration(seconds: 1),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  // To decide if we need to save chat or not
  bool compareChatData() {
    if (chat.value == null) return false;
    var chatText = UtilityService.extractMessageText(
      chat.value!,
      0,
      ChatDataType.text,
    );

    return ChatController.to.chatList.value.any(
      (chatMap) {
        return UtilityService.extractMessageText(
                chatMap['data'] as ChatSession, 0, ChatDataType.text) ==
            chatText;
      },
    );
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeOutCirc,
          );
        }
      },
    );
  }

  Future<void> sendChatMessage(String message) async {
    if (message.trim().isEmpty) return;
    if (chat.value == null) {
      showError('Chat session is not initialized.');
      return;
    }

    isLoading.value = true;
    try {
      final response = await chat.value!.sendMessage(
        Content.text(message),
      );
      if (response.text == null) {
        showError('Empty response.');
      }
      scrollDown();
    } catch (e) {
      showError(e.toString());
    } finally {
      textController.clear();
      textFieldFocus.unfocus();
      isLoading.value = false;
      chat.refresh();
    }
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
