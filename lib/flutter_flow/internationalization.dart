import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
  }) =>
      [enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    't5yi132h': {
      'en': 'SUSHIMAN',
      'es': '',
    },
    'u32nzdxp': {
      'en': 'THE TASTE OF \nJAPANESE FOOD',
      'es': '',
    },
    'fzj76kss': {
      'en':
          'Feel the taste of the mpst populars Japanese foos from anywhere and anytime.',
      'es': '',
    },
    '0rgvqprn': {
      'en': 'Get started',
      'es': '',
    },
    'j1p9sq69': {
      'en': 'Home',
      'es': '',
    },
  },
  // Miscellaneous
  {
    '4h8cdmvt': {
      'en': '',
      'es': '',
    },
    'dn67kqnp': {
      'en': '',
      'es': '',
    },
    'q1cls4xn': {
      'en': '',
      'es': '',
    },
    'dysjnr3q': {
      'en': '',
      'es': '',
    },
    'zhuqy25g': {
      'en': '',
      'es': '',
    },
    'c7zgptvb': {
      'en': '',
      'es': '',
    },
    'jah31kqe': {
      'en': '',
      'es': '',
    },
    'z2g5fjek': {
      'en': '',
      'es': '',
    },
    '16pky0te': {
      'en': '',
      'es': '',
    },
    'udzyotn8': {
      'en': '',
      'es': '',
    },
    '2xd9vycj': {
      'en': '',
      'es': '',
    },
    '1qfr02vi': {
      'en': '',
      'es': '',
    },
    'w291q6yp': {
      'en': '',
      'es': '',
    },
    '452v36h6': {
      'en': '',
      'es': '',
    },
    'mvkrv572': {
      'en': '',
      'es': '',
    },
    'uzmwbxyn': {
      'en': '',
      'es': '',
    },
    'y5wzeb2d': {
      'en': '',
      'es': '',
    },
    'uh3x1p7w': {
      'en': '',
      'es': '',
    },
    '1ayfob0o': {
      'en': '',
      'es': '',
    },
    '37vopn9e': {
      'en': '',
      'es': '',
    },
    'nqvksb98': {
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
