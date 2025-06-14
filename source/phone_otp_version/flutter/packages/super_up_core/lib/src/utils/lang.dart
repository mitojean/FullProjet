// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

final languageMap = {
  'af': 'Afrikaans',
  'sq': 'Shqip',
  'am': 'አማርኛ',
  'ar': 'عربي',
  'hy': 'Հայերեն',
  'az': 'Azərbaycan',
  'eu': 'Euskara',
  'be': 'Беларуская',
  'bn': 'বাংলা',
  'bs': 'Bosanski',
  'bg': 'Български',
  'ca': 'Català',
  'zh': '中文',
  'hr': 'Hrvatski',
  'cs': 'Čeština',
  'da': 'Dansk',
  'nl': 'Nederlands',
  'en': 'English',
  'et': 'Eesti',
  'fi': 'Suomi',
  'fr': 'Français',
  'gl': 'Galego',
  'ka': 'ქართული',
  'de': 'Deutsch',
  'el': 'Ελληνικά',
  'gu': 'ગુજરાતી',
  'hi': 'हिन्दी',
  'hu': 'Magyar',
  'is': 'Íslenska',
  'id': 'Indonesia',
  'ga': 'Gaeilge',
  'it': 'Italiano',
  'ja': '日本語',
  'jw': 'Jawa',
  'kn': 'ಕನ್ನಡ',
  'kk': 'Қазақ',
  'km': 'ខ្មែរ',
  'ko': '한국어',
  'lo': 'ລາວ',
  'lv': 'Latviešu',
  'lt': 'Lietuvių',
  'mk': 'Македонски',
  'ml': 'മലയാളം',
  'mr': 'मराठी',
  'my': 'မြန်မာ',
  'ne': 'नेपाली',
  'no': 'Norsk',
  'fa': 'فارسی',
  'pl': 'Polski',
  'pt': 'Português',
  'pa': 'ਪੰਜਾਬੀ',
  'ro': 'Română',
  'ru': 'Русский',
  'sr': 'Српски',
  'si': 'සිංහල',
  'sk': 'Slovenčina',
  'sl': 'Slovenščina',
  'es': 'Español',
  'sw': 'Kiswahili',
  'sv': 'Svenska',
  'ta': 'தமிழ்',
  'te': 'తెలుగు',
  'th': 'ไทย',
  'tr': 'Türkçe',
  'uk': 'Українська',
  'ur': 'اردو',
  'vi': 'Tiếng Việt',
  'cy': 'Cymraeg',
  'xh': 'IsiXhosa',
  'zu': 'IsiZulu',
};

String getFullLanguageName(String languageCode) {
  return languageMap[languageCode] ?? languageCode;
}
