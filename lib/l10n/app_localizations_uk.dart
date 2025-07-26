// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Shum UI';

  @override
  String get welcomeTitle => 'Привіт!';

  @override
  String get welcomeSubtitle => 'Отримай безпечний досвід покупок разом з нами';

  @override
  String get registerButton => 'Зареєструватись';

  @override
  String get loginButton => 'Увійти';

  @override
  String get skipButton => 'Пропустити цей крок';

  @override
  String get languageSelector => 'Мова';

  @override
  String get english => 'English';

  @override
  String get ukrainian => 'Українська';
}
