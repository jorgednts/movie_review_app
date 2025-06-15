import 'dart:convert';

import 'package:http/http.dart' as http;

import 'custom_http_client.dart';

class CustomHttpClientImpl implements CustomHttpClient {
  final http.Client _client;

  CustomHttpClientImpl(this._client);

  static const _tmdbApiToken = String.fromEnvironment('TMDB_API_TOKEN');

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _client.get(
      Uri.parse(url).replace(
        queryParameters: queryParameters?.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_tmdbApiToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET Error: ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_tmdbApiToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('POST Error: ${response.statusCode}');
    }
  }
}
