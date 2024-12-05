import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService extends GetxService {
  HiveService._();

  static final box = Hive.box("chad_ai");

  static Future<void> addUser({
    required String nama,
    required String email,
    required String password,
    required int pin,
  }) async {
    var box = Hive.box('chad_ai');
    var existingData = box.get(email) ?? {};

    var updatedData = {
      'username': nama,
      'password': password,
      'pin': pin,
      'chats': existingData['chats'] ?? [],
    };

    try {
      await box.put(email, updatedData);
    } catch (e) {
      log('Error saving data: $e');
    }
  }

  static Future<void> saveChat({
    required String email,
    required int id,
    required DateTime time,
    required ChatSession session,
  }) async {
    var box = Hive.box('chad_ai');

    var userData = box.get(email);

    if (userData != null) {
      // Add the new chat
      List<dynamic> chats = userData['chats'] ?? [];
      chats.add({
        'id': id,
        'time': time,
        'data': session,
      });

      // Update the user's data
      userData['chats'] = chats;
      await box.put(email, userData);
    } else {
      throw Exception('User not found');
    }
  }

  static List<dynamic> getChats({required String email}) {
    var box = Hive.box('chad_ai');

    // Get the user's data
    var userData = box.get(email);

    if (userData != null) {
      return userData['chats'] ?? [];
    } else {
      throw Exception('User not found');
    }
  }

  static Future<void> deleteChat({
    required String email,
    required int chatIndex, 
  }) async {
    var box = Hive.box('chad_ai');
    var userData = box.get(email);

    if (userData != null) {
      List<dynamic> chats = userData['chats'] ?? [];

      if (chatIndex >= 0 && chatIndex < chats.length) {
        chats.removeAt(chatIndex);

        userData['chats'] = chats;
        await box.put(email, userData);
      } else {
        throw Exception('Invalid chat index');
      }
    } else {
      throw Exception('User not found');
    }
  }

  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }
}
