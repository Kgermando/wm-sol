import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/balance_api.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BalanceController extends GetxController
    with StateMixin<List<BalanceModel>> {
  final BalanceApi balanceApi = BalanceApi();
  final ProfilController profilController = Get.find();

  List<BalanceModel> balanceList = []; 

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

  void clear() {
    montantDebitController.clear();
    montantCreditController.clear();
  }

  void getList() async {
    await balanceApi.getAllData().then((response) {
      balanceList.clear();
      balanceList.addAll(response); 
      change(balanceList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    }); 
  }

  detailView(int id) async {
    final data = await balanceApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await balanceApi.deleteData(id).then((value) {
        balanceList.clear();
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

  // Future<void> submit() async {
  //   try {
  //     _isLoading.value = true;
  //     var solde = double.parse((montantDebitController.text == "")
  //             ? "0"
  //             : montantDebitController.text) -
  //         double.parse((montantCreditController.text == "")
  //             ? "0"
  //             : montantCreditController.text);

  //     final balanceModel = BalanceModel( 
  //         comptes: comptes.toString(),
  //         debit: (montantDebitController.text == "")
  //             ? "0"
  //             : montantDebitController.text,
  //         credit: (montantCreditController.text == "")
  //             ? "0"
  //             : montantCreditController.text, 
  //         signature: profilController.user.matricule,
  //         created: DateTime.now()
  //     );
  //     await balanceApi.insertData(balanceModel).then((value) {
  //       clear();
  //       balanceList.clear();
  //       getList();
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

  // Future<void> submitUpdate(BalanceModel data) async {
  //   try {
  //     _isLoading.value = true;
  //     var solde = double.parse((montantDebitController.text == "")
  //             ? data.debit
  //             : montantDebitController.text) -
  //         double.parse((montantCreditController.text == "")
  //             ? data.credit
  //             : montantCreditController.text);

  //     final balanceModel = BalanceModel(
  //         id: data.id, 

  //         comptes: comptes.toString(),
  //         debit: (montantDebitController.text == "")
  //             ? data.debit
  //             : montantDebitController.text,
  //         credit: (montantCreditController.text == "")
  //             ? data.credit
  //             : montantCreditController.text, 
  //         signature: profilController.user.matricule,
  //         created: data.created
  //     );
  //     await balanceApi.updateData(balanceModel).then((value) {
  //       clear();
  //       balanceList.clear();
  //       getList();
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
