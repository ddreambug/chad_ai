import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatDetailController extends GetxController {
  static ChatDetailController get to => Get.find();

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
  }

  void resetModel() {
    savedChat.value = chat.value;
    chat.value = null;

    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: 'AIzaSyCJ5l9efz2xqJF5W80HB47KTFZJPBfhfvc',
      safetySettings: safetySetting,
      generationConfig: GenerationConfig(temperature: 1.6),
    );

    chat.value = model.startChat();
  }

  String extractMessageText(int chatOrder, ChatDataType targetType) {
    var chatHistory = chat.value?.history.toList() ?? [];

    if (targetType == ChatDataType.role) {
      return chatHistory[chatOrder].role!;
    } else {
      return chatHistory[chatOrder]
          .parts
          .whereType<TextPart>()
          .map<String>((e) => e.text)
          .join('');
    }
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
      print('current chat length: ${chat.value!.history.toList().length}');

      print(
        'first chat: ${extractMessageText(0, ChatDataType.text)}',
      );

      print(
        'role: ${extractMessageText(0, ChatDataType.role)}',
      );
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
