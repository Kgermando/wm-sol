import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/budgets/ligne_budgetaire_api.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart'; 
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class LignBudgetaireController extends GetxController
    with StateMixin<List<LigneBudgetaireModel>> {
  LIgneBudgetaireApi lIgneBudgetaireApi = LIgneBudgetaireApi();
  final ProfilController profilController = Get.find();

    var ligneBudgetaireList = <LigneBudgetaireModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomLigneBudgetaireController = TextEditingController();
  TextEditingController uniteChoisieController = TextEditingController();
  double nombreUniteController = 0.0;
  double coutUnitaireController = 0.0;
  double caisseController = 0.0;
  double banqueController = 0.0;

  @override
  void onInit() {
    super.onInit();
    getList(); 
  }

  @override
  void dispose() {
    nomLigneBudgetaireController.dispose();
    uniteChoisieController.dispose();

    super.dispose();
  }


 

  void getList() async {
    await lIgneBudgetaireApi.getAllData().then((response) {
      ligneBudgetaireList.assignAll(response);
      change(ligneBudgetaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await lIgneBudgetaireApi.getOneData(id);
    return data;
  }

  deleteData(int id) async {
    try {
      _isLoading.value = true;
      await lIgneBudgetaireApi.deleteData(id).then((value) {
        ligneBudgetaireList.clear();
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

  void submit(DepartementBudgetModel data) async {
    final coutToal = nombreUniteController * coutUnitaireController;
    final fonds = caisseController + banqueController;
    final fondsAtrouver = coutToal - fonds;
    try {
      _isLoading.value = true;
      final ligneBudgetaireModel = LigneBudgetaireModel(
          nomLigneBudgetaire: nomLigneBudgetaireController.text,
          departement: data.departement,
          periodeBudgetDebut: data.periodeDebut,
          periodeBudgetFin: data.periodeFin,
          uniteChoisie: uniteChoisieController.text,
          nombreUnite: nombreUniteController.toString(),
          coutUnitaire: coutUnitaireController.toString(),
          coutTotal: coutToal.toString(),
          caisse: caisseController.toString(),
          banque: banqueController.toString(),
          finExterieur: fondsAtrouver.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now());
      await lIgneBudgetaireApi.insertData(ligneBudgetaireModel).then((value) {
        ligneBudgetaireList.clear();
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
