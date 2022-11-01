import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/journal_api.dart';
import 'package:wm_solution/src/models/comptabilites/journal_livre_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class JournalController extends GetxController
    with StateMixin<List<JournalModel>> {
  final JournalApi journalApi = JournalApi();
  final ProfilController profilController = Get.find();

  var journalList = <JournalModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? comptesAllSelect;
  String? comptes;
  String? type;
  TextEditingController numeroOperationController = TextEditingController();
  TextEditingController libeleController = TextEditingController();
  TextEditingController montantDebitController = TextEditingController();
  TextEditingController montantCreditController = TextEditingController();
  TextEditingController tvaController = TextEditingController();
  TextEditingController remarqueController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    numeroOperationController.dispose();
    libeleController.dispose();
    montantDebitController.dispose();
    montantCreditController.dispose();
    tvaController.dispose();
    remarqueController.dispose();
    super.dispose();
  }

  void getList() async {
    await journalApi.getAllData().then((response) {
      journalList.assignAll(response);
      change(journalList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await journalApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await journalApi.deleteData(id).then((value) {
        journalList.clear();
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

  void submit(JournalLivreModel data) async {
    try {
      _isLoading.value = true;
      final journalModel = JournalModel(
          reference: data.id!,
          numeroOperation: numeroOperationController.text,
          libele: libeleController.text,
          compte: comptes.toString(),
          montantDebit: (montantDebitController.text == "")
              ? "0"
              : montantDebitController.text,
          montantCredit: (montantCreditController.text == "")
              ? "0"
              : montantCreditController.text,
          tva: tvaController.text,
          type: type.toString(),
          created: DateTime.now());
      await journalApi.insertData(journalModel).then((value) {
        journalList.clear();
        getList();
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

  void submitUpdate(JournalModel data) async {
    try {
      _isLoading.value = true;
      final journalModel = JournalModel(
          reference: data.id!,
          numeroOperation: data.numeroOperation,
          libele: libeleController.text,
          compte: comptes.toString(),
          montantDebit: (montantDebitController.text == "")
              ? data.montantDebit
              : montantDebitController.text,
          montantCredit: (montantCreditController.text == "")
              ? data.montantDebit
              : montantCreditController.text,
          tva: tvaController.text,
          type: type.toString(),
          created: DateTime.now());
      await journalApi.updateData(journalModel).then((value) {
        journalList.clear();
        getList();
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
