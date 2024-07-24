import 'dart:convert';

import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter/foundation.dart';

typedef OAuthTokenExtractor = OAuthToken Function(Response response);
typedef OAuthTokenValidator = Future<bool> Function(OAuthToken token);

class OAuthException extends Error {
  final String code;
  final String message;

  OAuthException(this.code, this.message) : super();

  @override
  String toString() => 'OAuthException: [$code] $message';
}

/// Interceptor to send the bearer access token and update the access token when needed
class AuthBearerInterceptor extends Interceptor {
  OAuth oauth;
  Future<void> Function(Exception error)? onInvalid;

  AuthBearerInterceptor(this.oauth, {this.onInvalid});

  /// Add Bearer token to Authorization Header
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handle) async {
    try {
      final token = await oauth.fetchOrRefreshAccessToken();
      if (token != null) {
        options.headers
            .addAll({"Authorization": "Bearer ${token.accessToken}"});
      }
    } on DioError catch (e) {
      if (onInvalid != null) {
        onInvalid!(e);
      }
      return handle.reject(e);
    }
    return handle.next(options);
  }
}

/// Use to implement a custom grantType
abstract class OAuthGrantType {
  RequestOptions handle(RequestOptions request);
}

/// Obtain an access token using a code
class CodeGrant extends OAuthGrantType {
  final String code;
  final String redirect_uri;
  final String code_verifier;
  final String ipAddress;

  CodeGrant(
      {this.code = '',
      this.redirect_uri = '',
      this.code_verifier = '',
      this.ipAddress = ''});

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data = {
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": redirect_uri,
      "code_verifier": code_verifier,
      'CLIENT_IP': ipAddress,
    };

    return request;
  }
}

/// Obtain an access token using an refresh token
class RefreshTokenGrant extends OAuthGrantType {
  String refreshToken;

  RefreshTokenGrant({required this.refreshToken});

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data = "grant_type=refresh_token&refresh_token=$refreshToken";
    return request;
  }
}

/// Use to implement custom token storage
abstract class OAuthStorage {
  /// Read token
  Future<OAuthToken?> fetch();

  /// Save Token
  Future<OAuthToken> save(OAuthToken token);

  /// Clear token
  Future<void> clear();
}

/// Save Token in Memory
class OAuthMemoryStorage extends OAuthStorage {
  OAuthToken? _token;

  /// Read
  @override
  Future<OAuthToken?> fetch() async {
    final expiration = getExpiryTokenTime();

    return OAuthToken(
        accessToken: getAccessToken(),
        refreshToken: getRefreshToken(),
        expiration: DateTime.tryParse(expiration.toString()));
  }

  /// Save
  @override
  Future<OAuthToken> save(OAuthToken token) async {
    saveAccessToken(token.accessToken);
    saveRefreshToken(token.refreshToken);
    saveIdToken(token.idToken);
    saveExpiryTokenTime(token.expiration);
    return _token = token;
  }

  /// Clear
  Future<void> clear() async {
    saveAccessToken("");
    saveRefreshToken("");
    saveIdToken("");
    saveExpiryTokenTime(null);
  }
}

/// Token
class OAuthToken {
  OAuthToken(
      {this.accessToken, this.refreshToken, this.expiration, this.idToken});

  final String? idToken;
  final String? accessToken;
  final String? refreshToken;
  final DateTime? expiration;

  bool get isExpired =>
      expiration != null && DateTime.now().isAfter(expiration!);

  factory OAuthToken.fromMap(Map<String, dynamic> map) {
    return OAuthToken(
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
      idToken: map['id_token'],
      expiration: DateTime.now().add(
        Duration(
          seconds: map['expires_in'] ?? map['expires'],
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'id_token': idToken,
        'expires_in': expiration?.millisecondsSinceEpoch,
      };

  String toString() {
    return 'OAuthToken{\naccess_token:${accessToken},\nrefresh_token:${refreshToken},\nexpires_in:${expiration}\id_token:${idToken}';
  }
}

/// Encode String To Base64
Codec<String, String> stringToBase64 = utf8.fuse(base64);

/// OAuth Client
class OAuth {
  String tokenUrl;
  String clientId;
  String clientSecret;
  Dio dio;
  OAuthStorage storage;
  OAuthTokenExtractor extractor;
  OAuthTokenValidator validator;

  OAuth({
    required this.tokenUrl,
    required this.clientId,
    required this.clientSecret,
    Dio? dio,
    OAuthStorage? storage,
    OAuthTokenExtractor? extractor,
    OAuthTokenValidator? validator,
  })  : dio = dio ?? Dio(),
        storage = storage ?? OAuthMemoryStorage(),
        extractor = extractor ?? ((res) => OAuthToken.fromMap(res.data)),
        validator = validator ?? ((token) => Future.value(!token.isExpired));

  Future<OAuthToken> requestTokenAndSave(OAuthGrantType grantType) async {
    return requestToken(grantType).then((token) => storage.save(token));
  }

  /// Request a new Access Token using a strategy
  Future<OAuthToken> requestToken(OAuthGrantType grantType) {
    final request = grantType.handle(
      RequestOptions(
        method: 'POST',
        path: '/',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          "Authorization":
              "Basic ${stringToBase64.encode('$clientId:$clientSecret')}"
          //"Authorization": "Basic ${stringToBase64.encode(clientId)}:${stringToBase64.encode(clientSecret)}"
        },
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(HttpFormatter());
    }
    return dio
        .request(tokenUrl,
            data: request.data,
            options: Options(
              contentType: request.contentType,
              headers: request.headers,
              method: request.method,
            ))
        .then((res) => extractor(res));
  }

  /// return current access token or refresh
  Future<OAuthToken?> fetchOrRefreshAccessToken() async {
    OAuthToken? token = await storage.fetch();

    if (token?.accessToken == null) {
      throw OAuthException('missing_access_token', 'Missing access token!');
    }

    if (await validator(token!)) return token;

    return refreshAccessToken();
  }

  /// Refresh Access Token
  Future<OAuthToken> refreshAccessToken() async {
    OAuthToken? token = await storage.fetch();

    if (token?.refreshToken == null) {
      throw OAuthException('missing_refresh_token', 'Missing refresh token!');
    }

    return requestTokenAndSave(
        RefreshTokenGrant(refreshToken: token!.refreshToken!));
  }
}
