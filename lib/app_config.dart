class AppConfig {
  static AppConfig get instance {
    if (_instance == null) {
      const apiKey = String.fromEnvironment('API_KEY');
      const baseUrl = String.fromEnvironment('BASE_URL');

      _instance = AppConfig._internal(apiKey, baseUrl);
      return _instance!;
    }

    return _instance!;
  }

  static AppConfig? _instance;

  AppConfig._internal(this.apiKey, this.baseUrl);

  final String apiKey;
  final String baseUrl;
}
