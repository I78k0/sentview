import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final result = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(result != null, 'No AppLocalizations found in context');
    return result!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'SentView',
      'welcome_title': 'Analyze smarter, communicate better',
      'welcome_subtitle': 'A modern platform for chat and sentiment analysis.',
      'login': 'Login',
      'register': 'Create Account',
      'email': 'Email',
      'password': 'Password',
      'username': 'Username',
      'full_name': 'Full Name',
    },
    'ar': {
      'app_name': 'سنت فيو',
      'welcome_title': 'حلّل بذكاء وتواصل بشكل أفضل',
      'welcome_subtitle': 'منصة حديثة للمحادثة وتحليل المشاعر والمحتوى.',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'username': 'اسم المستخدم',
      'full_name': 'الاسم الكامل',
    },
  };

  String text(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
