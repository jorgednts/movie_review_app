// core/network/custom_http_client_impl.dart

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'custom_http_client.dart';

class CustomHttpClientImpl implements CustomHttpClient {
  final http.Client _client;

  CustomHttpClientImpl(this._client);

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? headers}) async {
    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['TMDB_API_TOKEN']}',
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
        'Authorization': 'Bearer ${dotenv.env['TMDB_API_TOKEN']}',
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
