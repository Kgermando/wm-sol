import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/fin_exterieur_api.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_model.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_name_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class FinExterieurController extends GetxController
    with StateMixin<List<FinanceExterieurModel>> {
  final FinExterieurApi finExterieurApi = FinExterieurApi();
  final ProfilController profilController = Get.find();

  var finExterieurList = <FinanceExterieurModel>[].obs;

  final GlobalKey<FormState> formKeyDepot = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyRetrait = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController nomCompletController = TextEditingController();
  final TextEditingController pieceJustificativeController =
      TextEditingController();
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController montantController = TextEditingController();
  String? typeOperation;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

 

  @override
  void dispose() {
    nomCompletController.dispose();
    pieceJustificativeController.dispose();
    libelleController.dispose();
    montantController.dispose();
    super.dispose();
  }

  void getList() async {
    await finExterieurApi.getAllData().then((response) {
      finExterieurList.assignAll(response);

      change(finExterieurList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await finExterieurApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await finExterieurApi.deleteData(id).then((value) {
        finExterieurList.clear();
        getList();
        Get.back();
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

  void submitDepot(FinExterieurNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = FinanceExterieurModel(
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          typeOperation: 'Depot',
          numeroOperation:
              'Transaction-Autres-Fin-${finExterieurList.length + 1}',
          signature: profilController.user.matricule,
          reference: data.id!,
          financeExterieurName: data.nomComplet,
          created: DateTime.now());
      await finExterieurApi.insertData(dataItem).then((value) {
        finExterieurList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegader",
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

  void submitRetrait(FinExterieurNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = FinanceExterieurModel(
          id: data.id,
          nomComplet: nomCompletController.text,
          pieceJustificative: pieceJustificativeController.text,
          libelle: libelleController.text,
          montant: montantController.text,
          typeOperation: 'Retrait',
          numeroOperation:
              'Transaction-Autres-Fin-${finExterieurList.length + 1}',
          signature: profilController.user.matricule,
          reference: data.id!,
          financeExterieurName: data.nomComplet,
          created: data.created);
      await finExterieurApi.updateData(dataItem).then((value) {
        finExterieurList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegader",
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
}
