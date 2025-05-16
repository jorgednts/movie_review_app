abstract class CustomHttpClient {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> post(String url, {Map<String, dynamic>? body});
}
