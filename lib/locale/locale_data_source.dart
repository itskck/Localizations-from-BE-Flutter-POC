class LocaleDatasource {
  // This methode fetches all the locales that the app supports.
  static Future<List<String>> getSupportedLocales() async {
    return ['en', 'pl'];
  }

  // This method fetches the specific locale data. Say the app's current locale
  // is 'ar', then this method fetches locale data to support arabic translations.
  static Future<Map<String, dynamic>?> getLocaleData(String localeId) async {
    if (localeId == 'en') {
      print('Fetched EN');
      return {
        "title": "Hello World",
      };
    } else {
      print('Fetched PL');
      return {
        "title": "Witaj świecie",
      };
    }
  }
}
