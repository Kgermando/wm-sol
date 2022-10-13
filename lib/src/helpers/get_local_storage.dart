import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/models/users/user_model.dart';

class GetLocalStorage extends GetxController {
  static const _keyUser = 'userModel';
  static const _keyIdToken = 'idToken';
  static const _keyAccessToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';

  GetStorage box = GetStorage();

  final _id = ''.obs;
  String get id => _id.value;

  final _token = ''.obs;
  String get token => _token.value;

  Future<UserModel> read() async {
    final prefs = box.read(_keyUser);
    if (prefs != null) {
      UserModel user = UserModel.fromJson(jsonDecode(prefs));
      return user;
    } else {
      UserModel user = UserModel(
          nom: '-',
          prenom: '-',
          email: '-',
          telephone: '-',
          matricule: '-',
          departement: '-',
          servicesAffectation: '-',
          fonctionOccupe: '-',
          role: '5',
          isOnline: 'false',
          createdAt: DateTime.now(),
          passwordHash: '-',
          succursale: '-');
      return user;
    }
  }

  saveUser(value) async {
    box.write(_keyUser, json.encode(value));
  }

  removeUser() async {
    await box.remove(_keyUser);
  }

  // ID User
  getIdToken() {
    // box.read(_keyIdToken);
    final data = box.read(_keyIdToken);
    _id.value = data;
  }

  saveIdToken(value) {
    box.write(_keyIdToken, json.encode(value));
  }

  removeIdToken() {
    box.remove(_keyIdToken);
  }

  // AccessToken
  getAccessToken() {
    final data = box.read(_keyAccessToken);
    _token.value = data;
  }

  saveAccessToken(value) {
    box.write(_keyAccessToken, json.encode(value));
  }

  removeAccessToken() {
    box.remove(_keyAccessToken);
  }

  // RefreshToken
  getRefreshToken() {
    box.read(_keyRefreshToken);
  }

  saveRefreshToken(value) {
    box.write(_keyRefreshToken, json.encode(value));
  }

  removeRefreshToken() async {
    box.remove(_keyRefreshToken);
  }
}
