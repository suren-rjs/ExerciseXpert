import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _Secret {
  _Secret(this.key, this.value);

  final String key;
  final String value;
}

// ignore: library_private_types_in_public_api
_SecureStorage secureStorage = _SecureStorage.instance;

class _SecureStorage {
  _SecureStorage._();

  static final _SecureStorage instance = _SecureStorage._();

  final _accountNameController = TextEditingController(text: 'secure_storage');

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<_Secret> items = [];

  Future<String> get(String key) async {
    _Secret? item;
    try {
      item = items
          .where((element) => element.key.toLowerCase() == key.toLowerCase())
          .first;
    } catch (e) {
      log("Exception ( Secure Storage : $key not found )");
    }
    getAll();
    return item?.value ?? "";
  }

  Future<void> delete(String key) async {
    await storage.delete(
      key: key.toLowerCase(),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    getAll();
  }

  Future<void> getAll() async {
    final all = await storage.readAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    items = all.entries
        .map((entry) => _Secret(entry.key, entry.value))
        .toList(growable: false);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll(
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    getAll();
  }

  Future<void> add(String key, String value) async {
    await storage.write(
      key: key.toLowerCase(),
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    getAll();
  }

  Future<void> init() async {
    _accountNameController.addListener(() => getAll());
    getAll();
  }

  IOSOptions _getIOSOptions() => IOSOptions(accountName: _getAccountName());

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  String? _getAccountName() => _accountNameController.text;
}
