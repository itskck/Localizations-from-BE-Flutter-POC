import 'package:arb_poc/locale/locale_data_source.dart';

class LocaleAsset {
  static final LocaleAsset _instance = LocaleAsset._();

  LocaleAsset._();

  factory LocaleAsset() {
    return _instance;
  }

  static Map<String, dynamic>? localeAsset;

  static Future<void> getAsset(String localeId) async {
    final data = await LocaleDatasource.getLocaleData(localeId);
    localeAsset = data;
  }
}
