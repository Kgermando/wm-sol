import 'package:flutter/foundation.dart'; 
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/auth_api.dart';
import 'package:wm_solution/src/models/users/user_model.dart';

class ProfilController extends GetxController with StateMixin<UserModel> {
  final AuthApi authController = AuthApi();
  final box = GetStorage();

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

  UserModel get user => _user.value;

  @override
  void onInit() {
    super.onInit();

    getUser();
    
  }

  void getUser() async {
    _loadingProfil.value = true;
    await authController.getUserId().then((response) {
       _user.value = response; 
       if (kDebugMode) {
         print("Profil ${user.prenom}");
       }
      change(_user.value, status: RxStatus.success());
       _loadingProfil.value = false;
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
       _loadingProfil.value = false;
    });
  }


  // void getUser() async {
  //   _loadingProfil.value = true;

  //   await authController.getUserId().then((value) {
  //    _user.value = value; 
  //     _loadingProfil.value = false;
  //     debugPrint("user profil: ${_user.value.matricule}");
  //     update();
  //   });
  // }
}
