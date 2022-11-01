import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/compte_balance_ref_api.dart';
import 'package:wm_solution/src/models/comptabilites/balance_comptes_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BalanceRefController extends GetxController
    with StateMixin<List<CompteBalanceRefModel>> {
  final CompteBalanceRefApi compteBalanceRefApi = CompteBalanceRefApi();
  final ProfilController profilController = Get.find();

  var compteBalanceRefList = <CompteBalanceRefModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? comptesAllSelect;
  String? comptes;
  TextEditingController montantDebitController = TextEditingController();
  TextEditingController montantCreditController = TextEditingController();
  bool statut = false;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

 
  @override
  void dispose() {
    montantDebitController.dispose();
    montantCreditController.dispose();
    super.dispose();
  }

  void getList() async {
    await compteBalanceRefApi.getAllData().then((response) {
      compteBalanceRefList.assignAll(response);
      change(compteBalanceRefList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await compteBalanceRefApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await compteBalanceRefApi.deleteData(id).then((value) {
        compteBalanceRefList.clear();
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

  Future<void> submit(BalanceCompteModel data) async {
    try {
      _isLoading.value = true;
      var solde = double.parse((montantDebitController.text == "")
              ? "0"
              : montantDebitController.text) -
          double.parse((montantCreditController.text == "")
              ? "0"
              : montantCreditController.text);
      final compteBalanceRefModel = CompteBalanceRefModel(
          reference: data.id!,
          comptes: comptes.toString(),
          debit: (montantDebitController.text == "")
              ? "0"
              : montantDebitController.text,
          credit: (montantCreditController.text == "")
              ? "0"
              : montantCreditController.text,
          solde: solde.toString());
      await compteBalanceRefApi.insertData(compteBalanceRefModel).then((value) {
        compteBalanceRefList.clear();
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

  Future<void> submitEdit(CompteBalanceRefModel compte) async {
    try {
      _isLoading.value = true;
      var solde = double.parse((montantDebitController.text == "")
              ? compte.debit
              : montantDebitController.text) -
          double.parse((montantCreditController.text == "")
              ? compte.credit
              : montantCreditController.text);

      final compteBalanceRefModel = CompteBalanceRefModel(
          id: compte.id,
          reference: compte.reference,
          comptes: comptes.toString(),
          debit: (montantDebitController.text == "")
              ? compte.debit
              : montantDebitController.text,
          credit: (montantCreditController.text == "")
              ? compte.credit
              : montantCreditController.text,
          solde: solde.toString());
      await compteBalanceRefApi.updateData(compteBalanceRefModel).then((value) {
        compteBalanceRefList.clear();
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

  // void sendDD(BalanceCompteModel data) async {
  //   try {
  //     _isLoading.value = true;
  //     final bilanModel = BalanceCompteModel(
  //         id: data.id,
  //         title: data.title,
  //         statut: data.statut,
  //         signature: data.signature,
  //         created: data.created,
  //         isSubmit: 'true',
  //         approbationDG: data.approbationDG,
  //         motifDG: data.motifDG,
  //         signatureDG: data.signatureDG,
  //         approbationDD: data.approbationDD,
  //         motifDD: data.motifDD,
  //         signatureDD: data.signatureDD);
  //     await balanceCompteApi.updateData(bilanModel).then((value) {
  //       balanceList.clear();
  //       getList();
  //       Get.back();
  //       Get.snackbar("Soumission effectuée avec succès!",
  //           "Le document a bien été sauvegader",
  //           backgroundColor: Colors.green,
  //           icon: const Icon(Icons.check),
  //           snackPosition: SnackPosition.TOP);
  //       _isLoading.value = false;
  //     });
  //   } catch (e) {
  //     Get.snackbar("Erreur de soumission", "$e",
  //         backgroundColor: Colors.red,
  //         icon: const Icon(Icons.check),
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
