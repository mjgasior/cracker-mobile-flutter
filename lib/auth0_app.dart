import 'dart:convert';

import 'package:cracker_app/+widgets/login.dart';
import 'package:cracker_app/+widgets/markers.dart';
import 'package:cracker_app/+widgets/profile.dart';
import 'package:cracker_app/+widgets/version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

const AUTH0_DOMAIN = 'fulbert.eu.auth0.com';
const AUTH0_CLIENT_ID = 'KZZWiCz61h8DNxs1DSYxPM7xfxkLDEKF';

const AUTH0_REDIRECT_URI = 'com.cracker.app://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
const $AUTH0_AUDIENCE = 'https://cracker.app';

class Auth0App extends StatefulWidget {
  final onLoginCallback;
  final onLogoutCallback;

  const Auth0App(this.onLoginCallback, this.onLogoutCallback);

  @override
  _Auth0AppState createState() => _Auth0AppState();
}

class _Auth0AppState extends State<Auth0App> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  String name;
  String picture;
  String accessToken = "";

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<Map<String, dynamic>> getUserDetails(String accessToken) async {
    final url = 'https://$AUTH0_DOMAIN/userinfo';
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    widget.onLogoutCallback();
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: 'https://$AUTH0_DOMAIN',
          scopes: ['openid', 'profile', 'offline_access'],
          discoveryUrl: '$AUTH0_ISSUER/.well-known/openid-configuration',
          additionalParameters: {"audience": $AUTH0_AUDIENCE},
        ),
      );

      final idToken = parseIdToken(result.idToken);
      final profile = await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
        accessToken = result.accessToken;
      });

      widget.onLoginCallback(result.accessToken);
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    try {
      final response = await appAuth.token(TokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUTH0_ISSUER,
        refreshToken: storedRefreshToken,
        discoveryUrl: '$AUTH0_ISSUER/.well-known/openid-configuration',
        additionalParameters: {"audience": $AUTH0_AUDIENCE},
      ));

      final idToken = parseIdToken(response.idToken);
      final profile = await getUserDetails(response.accessToken);

      secureStorage.write(key: 'refresh_token', value: response.refreshToken);

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
        accessToken = response.accessToken;
      });

      widget.onLoginCallback(response.accessToken);
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = isBusy
        ? Padding(
            padding: const EdgeInsets.all(30),
            child: CircularProgressIndicator())
        : isLoggedIn
            ? Profile(logoutAction, name, picture)
            : Login(loginAction, errorMessage);

    return Column(
      children: [content, Markers(), Version(isLoggedIn)],
    );
  }
}
