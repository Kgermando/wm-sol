import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:wm_solution/src/api/devis/devis_api.dart'; 
import 'package:wm_solution/src/models/devis/devis_models.dart';

class DevisController extends GetxController
    with StateMixin<List<DevisModel>> {
  final DevisAPi devisAPi = DevisAPi();

  var devisList = <DevisModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
 

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    devisAPi.getAllData().then((response) {
      devisList.assignAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await devisAPi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await devisAPi.deleteData(id).then((value) {
        devisList.clear();
        getList();
        // Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  // Future<void> succursaleUser(SuccursaleModel user) async {
  //   try {
  //     final userModel = UserModel(
  //         id: user.id,
  //         nom: user.nom,
  //         prenom: user.prenom,
  //         email: user.email,
  //         telephone: user.telephone,
  //         matricule: user.matricule,
  //         departement: user.departement,
  //         servicesAffectation: user.servicesAffectation,
  //         fonctionOccupe: user.fonctionOccupe,
  //         role: user.role,
  //         isOnline: user.isOnline,
  //         createdAt: user.createdAt,
  //         passwordHash: user.passwordHash,
  //         succursale: succursale.toString());
  //     await userApi.updateData(userModel).then((value) {
  //       usersList.clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar(
  //           "Succursale ajoutée avec succès!", "Le document a bien été soumis",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     Get.snackbar("Erreur lors de la soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
