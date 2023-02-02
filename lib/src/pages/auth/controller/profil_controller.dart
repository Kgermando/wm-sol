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

  // late UserModel user;
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
  void onInit() async {
    _user.value = await userData(); 
    super.onInit();
    if (kDebugMode) {
      print("Profil user ${user.prenom}");
    }
    
  }

  Future<UserModel> userData() async {
    late UserModel userModel;
    final getStorge = GetStorage();
    String? idToken = getStorge.read('idToken');

    if (idToken != null) {
      _loadingProfil.value = true;
      await authController.getUserId().then((response) {
        userModel = response;
        if (kDebugMode) {
          print("Profil user ${userModel.prenom}");
        }
        change(userModel, status: RxStatus.success());
        _loadingProfil.value = false;
      }, onError: (err) { 
        change(null, status: RxStatus.error(err.toString()));
        _loadingProfil.value = false;
      });
    }

    return userModel;
  }

  // void getUser() async {
  //   final getStorge = GetStorage();
  //   String? idToken = getStorge.read('idToken');

  //   if (idToken != null) {
  //     _loadingProfil.value = true;
  //     await authController.getUserId().then((response) {
  //       _user.value = response;
  //       if (kDebugMode) {
  //         print("Profil ${_user.value.prenom}");
  //       }
  //       change(_user.value, status: RxStatus.success());
  //       _loadingProfil.value = false;
  //     }, onError: (err) {
  //       change(null, status: RxStatus.error(err.toString()));
  //       _loadingProfil.value = false;
  //     });
  //   }
  // }

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
