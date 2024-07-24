import 'dart:convert';
import 'dart:math';

import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:cryptography/cryptography.dart' as crypto;

class AuthorizationResult {
  String codeVerifier;
  Uri authorizeUri;

  AuthorizationResult(this.codeVerifier, this.authorizeUri);
}

Future<AuthorizationResult> createAuthorizationRequest() async {
  var authorizeRequest = Uri.parse(ApiEndpoints.authorizeEndPoint);

  var nonce = _createRandomKeyString(128);
  var codeVerifier = _createRandomKeyString(128);
  var challenge = await toCodeChallenge(codeVerifier);

  var dic = {
    "client_id": ApiEndpoints.clientId,
    "response_type": ApiEndpoints.responseType,
    "scope": ApiEndpoints.scope,
    "redirect_uri": ApiEndpoints.logInCallBack,
    "nonce": nonce,
    "code_challenge": challenge,
    "code_challenge_method": "S256",
    "state": _generateCSRFToken(),
  };

  var authorizeUri = Uri(
    scheme: authorizeRequest.scheme,
    host: authorizeRequest.host,
    path: authorizeRequest.path,
    queryParameters: dic,
  );

  return AuthorizationResult(codeVerifier, authorizeUri);
}

String _createRandomKeyString(int length) {
  const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
  return List.generate(
      length, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
}

String _generateCSRFToken() {
  return Random.secure().nextDouble().toString();
}

Future<String> toCodeChallenge(String codeVerifier) async {
  if (codeVerifier.isEmpty || codeVerifier.trim().isEmpty) return '';

  final sha256 = crypto.Sha256();

  final codeChallenge = base64Url
      .encode((await sha256.hash(ascii.encode(codeVerifier))).bytes)
      .replaceAll('=', '');
  return codeChallenge;
}

Uri createLogoutRequest(String? token) {
  if (token == null || token.isEmpty) {
    return Uri.parse("");
  }
  var authorizeRequest = Uri.parse(ApiEndpoints.sessionEndpoint);
  var dic = {
    "id_token_hint": token,
    "post_logout_redirect_uri": ApiEndpoints.logOutCallBack
  };
  var authorizeUri = Uri(
    scheme: authorizeRequest.scheme,
    host: authorizeRequest.host,
    path: authorizeRequest.path,
    queryParameters: dic,
  );
  return authorizeUri;
}
