import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/caisse_name_api.dart';
import 'package:wm_solution/src/models/finances/caisse_name_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class CaisseNameController extends GetxController
    with StateMixin<List<CaisseNameModel>> {
  final CaisseNameApi caisseNameApi = CaisseNameApi();
  final ProfilController profilController = Get.find();

  var caisseNameList = <CaisseNameModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomCompletController = TextEditingController();
  TextEditingController rccmController = TextEditingController();
  TextEditingController idNatController = TextEditingController();
  TextEditingController addresseController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomCompletController.dispose();
    rccmController.dispose();
    idNatController.dispose();
    addresseController.dispose();
    super.dispose();
  }

  void getList() async {
    await caisseNameApi.getAllData().then((response) {
      caisseNameList.assignAll(response);
      change(caisseNameList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await caisseNameApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await caisseNameApi.deleteData(id).then((value) {
        caisseNameList.clear();
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

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = CaisseNameModel(
          nomComplet: nomCompletController.text,
          rccm: (rccmController.text == '') ? '-' : rccmController.text,
          idNat: (idNatController.text == '') ? '-' : idNatController.text,
          addresse:
              (addresseController.text == '') ? '-' : addresseController.text,
          created: DateTime.now());
      await caisseNameApi.insertData(dataItem).then((value) {
        caisseNameList.clear();
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

  void submitUpdate(CaisseNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CaisseNameModel(
          id: data.id,
          nomComplet: (nomCompletController.text == '')
              ? data.nomComplet
              : nomCompletController.text,
          rccm: (rccmController.text == '') ? data.rccm : rccmController.text,
          idNat:
              (idNatController.text == '') ? data.idNat : idNatController.text,
          addresse: (addresseController.text == '')
              ? data.addresse
              : addresseController.text,
          created: data.created);
      await caisseNameApi.updateData(dataItem).then((value) {
        caisseNameList.clear();
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
