import 'package:arb_poc/cubit/locale_cubit.dart';
import 'package:arb_poc/i18n/locale_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationManager {
  final Locale locale;
  const LocalizationManager(this.locale);

  Map? get _localizedStrings => LocaleAsset.localeAsset;

  static LocalizationManager? of(BuildContext context) {
    final localizations =
        Localizations.of<LocalizationManager>(context, LocalizationManager);

    return localizations;
  }

  Future<void> load() async {
    await LocaleAsset.getAsset(locale.languageCode);
  }

  String getString(String key) {
    return _localizedStrings?[key] ?? '';
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<LocalizationManager> {
  const AppLocalizationDelegate(this.context);

  final BuildContext context;

  @override
  bool isSupported(Locale locale) {
    return context.read<LocaleCubit>().state.supportedLocales.contains(locale);
  }

  @override
  Future<LocalizationManager> load(Locale locale) async {
    print('loading $locale');
    final localizations = LocalizationManager(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationManager> old) {
    return false;
  }
}
