import 'package:encrypt/encrypt.dart';

class EncryptUtil {
  static var key = Key.fromUtf8('A@:56/~85gWoO~7k');
  static var iv = IV.fromUtf8('A@:56/~85gWoO~7k');

  static String encryptedData(String param) {
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    final data = encrypt.encrypt(param, iv: iv).base64;
    return data;
  }

  static String decryptedData(String param) {
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    final data = encrypt.decrypt64(param, iv: iv);
    return data;
  }
}
