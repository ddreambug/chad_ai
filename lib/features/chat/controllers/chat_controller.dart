import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();

  late final GenerativeModel model;
  var chatList = Rx<List<Map<String, dynamic>>>([]);
  var hiveChat = Rx<List<Map<String, dynamic>>>([]);

  late final String currentEmail;

  @override
  void onInit() {
    super.onInit();

    currentEmail = Get.arguments;
    getChats();
  }

  void getChats() {
    var chats = HiveService.getChats(email: currentEmail);
    hiveChat.value = List<Map<String, dynamic>>.from(chats);
    hiveChat.refresh();

    // Print the actual values for debugging
    print('hiveChat: ${hiveChat.value}');
    print('chatList: $chatList');
  }

  //Delete
  void deleteChat(int index) {
    if (index >= 0 && index < hiveChat.value.length) {
      hiveChat.value.removeAt(index);
      hiveChat.refresh();

      print('current email: $currentEmail');
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
  var selectedIndex = 0.obs;
  void selectPage(int index) {
    selectedIndex.value = index;
  }
}
