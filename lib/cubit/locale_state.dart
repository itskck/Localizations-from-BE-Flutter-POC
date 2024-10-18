import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const LocaleState._();
  factory LocaleState.initial() = _Initial;
  factory LocaleState.loading() = _Loading;
  factory LocaleState.loaded({
    required String locale,
    required List<String> locales,
  }) = _Loaded;
  factory LocaleState.error() = _Error;

  List<Locale> get supportedLocales => maybeMap(
        orElse: () => [const Locale('en')],
        loaded: (state) => state.locales.map((e) => Locale(e)).toList(),
      );

  Locale get currentLocale => maybeMap(
        loaded: (state) => Locale(state.locale),
        orElse: () => const Locale('en'),
      );
}
