// lib/core/utils/secure_storage.dart
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = const FlutterSecureStorage();

Future<void> generateAndStoreKey() async {
  // Check if keys already exist to avoid regenerating
  final hasKey = await storage.containsKey(key: 'enc_key');
  if (hasKey) return;

  // Generate AES-256 key and IV
  final key = encrypt.Key.fromSecureRandom(32); // 256-bit key
  final iv = encrypt.IV.fromSecureRandom(16); // 128-bit IV

  // Store securely
  await storage.write(key: 'enc_key', value: key.base64);
  await storage.write(key: 'enc_iv', value: iv.base64);
}

Future<File> encryptFile(
    File inputFile, String outputPath, String keyStr) async {
  final key = encrypt.Key.fromUtf8(keyStr.padRight(32, '0')); // AES-256
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final bytes = await inputFile.readAsBytes();
  final encrypted = encrypter.encryptBytes(bytes, iv: iv);

  final outFile = File(outputPath);
  return await outFile.writeAsBytes(encrypted.bytes, flush: true);
}
