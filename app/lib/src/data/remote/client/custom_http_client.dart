abstract class CustomHttpClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? headers});

  Future<dynamic> post(String url, {Map<String, dynamic>? body});
}
