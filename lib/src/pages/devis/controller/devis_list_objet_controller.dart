import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/devis/devis_list_objets_api.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart'; 

class DevisListObjetController extends GetxController
    with StateMixin<List<DevisListObjetsModel>> {
  final DevisListObjetsApi devisListObjetsApi = DevisListObjetsApi();

  var devisListObjetList = <DevisListObjetsModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
 
  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    devisListObjetsApi.getAllData().then((response) {
      devisListObjetList.assignAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await devisListObjetsApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await devisListObjetsApi.deleteData(id).then((value) {
        devisListObjetList.clear();
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
