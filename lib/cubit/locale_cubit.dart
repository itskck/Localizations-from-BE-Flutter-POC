import 'dart:ui';

import 'package:arb_poc/cubit/locale_state.dart';
import 'package:arb_poc/locale/locale_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState.initial());

  Future<void> init() async {
    final supportedLocales = await LocaleDatasource.getSupportedLocales();

    emit(LocaleState.loaded(
      locale: supportedLocales.contains('en') ? 'en' : supportedLocales.first,
      locales: supportedLocales,
    ));
  }

  void switchLocale(Locale e) {
    final localesFromState = state.maybeMap(
      orElse: () => <String>[],
      loaded: (state) => state.locales,
    );
    emit(LocaleState.loaded(
      locale: e.languageCode,
      locales: localesFromState,
    ));
  }
}
