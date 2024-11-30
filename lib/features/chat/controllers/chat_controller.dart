import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();

  late final GenerativeModel model;
  var chat = Rx<ChatSession?>(null);
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: 'AIzaSyCJ5l9efz2xqJF5W80HB47KTFZJPBfhfvc',
    );
    chat.value = model.startChat();
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
