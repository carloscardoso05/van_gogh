class Env {
  static const Map<String, String> _keys = {
    'API_URL': String.fromEnvironment('API_URL'),
    'API_KEY': String.fromEnvironment('API_KEY'),
  };
  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key is not set in env');
    }
    return value;
  }

  static String get apiUrl => _getKey('API_URL');
  static String get apiKey => _getKey('API_KEY');
}
