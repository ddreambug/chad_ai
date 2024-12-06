import 'package:chad_ai/utils/enums/enum.dart';
import 'package:chad_ai/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  var arguments = Get.arguments;

  late final GenerativeModel model;
  var chatList = Rx<List<Map<String, dynamic>>>([]);
  late final String currentName;
  late final int currentPin;
  late final bool currentIsGoogle;
  late final String currentEmail;
  late final String currentPassword;
  late final String currentAvatar;

  @override
  void onInit() {
    super.onInit();

    currentName = arguments['name'];
    currentPin = arguments['pin'];
    currentIsGoogle = arguments['isGoogle'];
    currentEmail = arguments['email'];
    currentPassword = arguments['password'];
    currentAvatar = arguments['avatar'];

    getChats();
  }

  //Get
  void getChats() {
    var chats = HiveService.getChats(email: currentEmail);

    chatList.value = List<Map<String, dynamic>>.from(chats);
    chatList.refresh();
  }

  //Delete
  void deleteChat(int index) {
    HiveService.deleteChat(
      email: ChatController.to.currentEmail,
      chatIndex: index,
    );
    ChatController.to.getChats();
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

  //Sidebar
  Rx<ViewType> viewType = ViewType.allChat.obs;

  //Appbar
  RxString appbarTitle = 'All Chat'.obs;
}
