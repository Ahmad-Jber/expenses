import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final _storage = FlutterSecureStorage(
    aOptions: AndroidOptions.biometric(
      enforceBiometrics: false, // Works without biometrics
      biometricPromptTitle: 'Authenticate to access data',
    ),
  );

  static Future storeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String> readData(String key) async {
    var result = await _storage.read(key: key);
    if (result == null) return "";
    return result;
  }

  static Future deleteData(String key) async {
    await _storage.delete(key: key);
  }

  static Future clearAllData() async {
    _storage.deleteAll();
  }
}
