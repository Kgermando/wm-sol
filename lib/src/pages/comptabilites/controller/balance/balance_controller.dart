import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/balance_compte_api.dart'; 
import 'package:wm_solution/src/models/comptabilites/balance_comptes_model.dart'; 
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BalanceController extends GetxController with StateMixin<List<BalanceCompteModel>> {
  final BalanceCompteApi balanceCompteApi = BalanceCompteApi();
  final ProfilController profilController = Get.find();

  var balanceList = <BalanceCompteModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController titleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void getList() async {
    await balanceCompteApi.getAllData().then((response) {
      balanceList.assignAll(response);
      change(balanceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await balanceCompteApi.getOneData(id);
    return data;
  }

  deleteData(int id) async {
    try {
      _isLoading.value = true;
      await balanceCompteApi.deleteData(id).then((value) {
        balanceList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final balance = BalanceCompteModel(
        title: titleController.text,
        statut: 'false',
        signature: profilController.user.matricule.toString(),
        created: DateTime.now(),
        isSubmit: 'false',
        approbationDG: '-',
        motifDG: '-',
        signatureDG: '-',
        approbationDD: '-',
        motifDD: '-',
        signatureDD: '-');
      await balanceCompteApi.insertData(balance).then((value) {
        balanceList.clear();
        getList();
        // Get.back();
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

  sendDD(BalanceCompteModel data) async {
    try {
      _isLoading.value = true;
      final bilanModel = BalanceCompteModel(
          id: data.id,
          title: data.title,
          statut: data.statut,
          signature: data.signature,
          created: data.created,
          isSubmit: 'true',
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await balanceCompteApi.updateData(bilanModel).then((value) {
        balanceList.clear();
        getList();
        // Get.back();
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
