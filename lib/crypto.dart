import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';

class Crypto {
  static const String _encryptedKey = "1234567gd*+n6s2k"; //16 char
  static const String _encryptedInitVector = 'hdv7R3Bj3bKd8sa\$'; //16 char

  static encrypt(String data) {
    final key = enc.Key.fromUtf8(_encryptedKey);
    final iv = IV.fromUtf8(_encryptedInitVector);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  static decrypt(String data) {
    try {
      final key = enc.Key.fromUtf8(_encryptedKey);
      final iv = IV.fromUtf8(_encryptedInitVector);
      final encrypted =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final decrypted = encrypted.decrypt(Encrypted.from64(data), iv: iv);

      return decrypted;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }
}
