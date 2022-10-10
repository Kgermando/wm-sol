import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/models/users/user_model.dart';

class ProfilController extends GetxController with StateMixin<UserModel> {
  final AuthApi authController = AuthApi();

  UserModel get user => _user.value;

  final _loadingProfil = false.obs;
  bool get isLoadingProfil => _loadingProfil.value;

  final _user = UserModel(
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
          succursale: '-')
      .obs;

  @override
  void onInit() {
    // profil();

    super.onInit();
    _loadingProfil.value = true;
    authController.getUserId().then((value) {
      _user.value = value;
      _loadingProfil.value = false;
      update();
      debugPrint("user profil: ${_user.value.matricule}");
    });
    print("Profil ${user.fonctionOccupe}");
  }

  // void profil() {
  //   _loadingProfil.value = true;
  //   authController.getUserId().then((value) {
  //     _user.value = value;
  //     _loadingProfil.value = false;
  //     debugPrint("user profil: ${_user.value.matricule}");
  //   });
  // }

}
