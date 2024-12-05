import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();

  late final GenerativeModel model;
  var chatList = Rx<List<Map<String, dynamic>>>([]);

  //Delete
  void deleteChat(int index) {
    if (index >= 0 && index < chatList.value.length) {
      chatList.value.removeAt(index);
      chatList.refresh();

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
  }

  //sidebar
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedIndex = 0.obs;
  void selectPage(int index) {
    selectedIndex.value = index;
  }
}
