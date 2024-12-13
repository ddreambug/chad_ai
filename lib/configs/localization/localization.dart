import 'package:chad_ai/configs/localization/langs/en_us.dart';
import 'package:chad_ai/configs/localization/langs/id_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Localization extends Translations {
  // locale list constant
  static const defaultLocale = Locale('en', 'US');
  static const fallbackLocale = Locale('id', 'ID');
  static const locales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];
  static const langs = [
    'English',
    'Indonesia',
  ];

  // locale keys constants
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': translationsEnUs,
        'id_ID': translationsIdId,
      };

  // change locale
  static void changeLocale(String lang) async {
    final locale = getLocaleFromLanguage(lang);
    await Get.updateLocale(locale);
  }

  // search for language and return locale
  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (langs[i].toLowerCase() == lang.toLowerCase()) {
        return locales[i];
      }
    }

    return defaultLocale;
  }

  // get current locale
  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  // get current language
  static String get currentLanguage {
    return langs.elementAt(locales.indexOf(currentLocale));
  }
}
