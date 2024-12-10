import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveDetailController extends GetxController {
  static ArchiveDetailController get to => Get.find();
  var archivedChat = Rx<List<Map<String, dynamic>>>([]);
  final ScrollController scrollController = ScrollController();
  late final int archiveIndex;

  @override
  void onInit() {
    super.onInit();

    Map<String, dynamic> arguments = Get.arguments;
    if (arguments.isNotEmpty) {
      archiveIndex = arguments['index'];
      archivedChat.value = List<Map<String, dynamic>>.from(arguments['data']);
    }
  }
}
