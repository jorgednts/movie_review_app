// Mocks generated by Mockito 5.4.6 from annotations
// in app/test/src/data/remote/tmdb_remote_data_source_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:app/src/data/remote/client/custom_http_client.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CustomHttpClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomHttpClient extends _i1.Mock implements _i2.CustomHttpClient {
  MockCustomHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<dynamic> get(
    String? url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #get,
              [url],
              {#headers: headers, #queryParameters: queryParameters},
            ),
            returnValue: _i3.Future<dynamic>.value(),
          )
          as _i3.Future<dynamic>);

  @override
  _i3.Future<dynamic> post(String? url, {Map<String, dynamic>? body}) =>
      (super.noSuchMethod(
            Invocation.method(#post, [url], {#body: body}),
            returnValue: _i3.Future<dynamic>.value(),
          )
          as _i3.Future<dynamic>);
}
