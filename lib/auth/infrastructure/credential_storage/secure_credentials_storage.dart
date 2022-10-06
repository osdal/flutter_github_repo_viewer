import 'dart:html';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: implementation_imports
import 'package:oauth2/src/credentials.dart';

// ignore: always_use_package_imports
import 'credential_storage.dart';

class SecureCredentialsStorage implements CredentialStorage {
  final FlutterSecureStorage _storage;

  SecureCredentialsStorage(this._storage);
  static const _key = 'oauth_credentials';

  Credentials? _cashCredentials;

  @override
  Future<Credentials?> read() async {
    if (_cashCredentials != null) {
      return _cashCredentials;
    }
    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }
    try {
      return _cashCredentials = Credentials.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) {
    _cashCredentials = credentials;
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    _cashCredentials = null;
    return _storage.delete(key: _key);
  }
}
