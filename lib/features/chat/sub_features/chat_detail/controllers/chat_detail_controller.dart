import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/utility_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatDetailController extends GetxController {
  static ChatDetailController get to => Get.find();

  final ChatSession? arguments = Get.arguments;
  late final GenerativeModel model;
  var chat = Rx<ChatSession?>(null);
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  var isLoading = false.obs;
  final safetySetting = [
    SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
    SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
  ];
  var savedChat = Rx<ChatSession?>(null);

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
      chat.value = arguments;
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (chat.value != null && chat.value!.history.length >= 2) {
      if (!compareChatData()) {
        ChatController.to.chatList.value.add(
          {
            'id': DateTime.now().millisecondsSinceEpoch,
            'time': DateTime.now(),
            'data': chat.value!,
          },
        );
        ChatController.to.chatList.refresh();
      }
    }
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
