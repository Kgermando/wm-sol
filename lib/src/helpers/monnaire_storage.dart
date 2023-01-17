import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MonnaieStorage extends GetxController {
  static const _keyMonnaie = 'monnaie';
  GetStorage box = GetStorage();

  final _monney = '\$'.obs;
  String get monney => _monney.value;

  getData() {
    final data = box.read(_keyMonnaie);
    _monney.value = json.decode(data);
  }

  setData(value) async {
    box.write(_keyMonnaie, json.encode(value));
  }

  removeData() async {
    await box.remove(_keyMonnaie);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getList();
  // }

  // void getList() async {
  //   await monnaieApi.getAllData().then((response) {
  //     _monney.value = response.first.monnaie;
  //   });
  // }

  // void deleteData(int id) async {
  //   try {
  //     _isLoading.value = true;
  //     await monnaieApi.deleteData(id).then((value) {
  //       getList();
  //       // Get.back();
  //       Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     _isLoading.value = false;
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }

  // void submit(String simbol, String lettre) async {
  //   try {
  //     _isLoading.value = true;
  //     final dataItem = MonnaieModel(
  //         monnaie: simbol,
  //         monnaieEnlettre: lettre,
  //         signature: profilController.user.matricule,
  //         created: DateTime.now());
  //     await monnaieApi.insertData(dataItem).then((value) {
  //       // clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar("Monnaie effectuée avec succès!",
  //           "Le document a bien été sauvegadé",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     _isLoading.value = false;
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }

  // void updateData(String simbol, String lettre) async {
  //   try {
  //     _isLoading.value = true;
  //     final dataItem = MonnaieModel(
  //         monnaie: simbol,
  //         monnaieEnlettre: lettre,
  //         signature: profilController.user.matricule,
  //         created: DateTime.now());
  //     await monnaieApi.updateData(dataItem).then((value) {
  //       // clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar("Modification effectuée avec succès!",
  //           "Le document a bien été sauvegadé",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     _isLoading.value = false;
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
