abstract class TokenStorage {
  Future<String?> readAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> clearAccessToken();
}

class InMemoryTokenStorage implements TokenStorage {
  String? _accessToken;

  @override
  Future<String?> readAccessToken() async {
    return _accessToken;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    _accessToken = token;
  }

  @override
  Future<void> clearAccessToken() async {
    _accessToken = null;
  }
}
