import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/banque_name_api.dart';
import 'package:wm_solution/src/models/finances/banque_name_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class BanqueNameController extends GetxController
    with StateMixin<List<BanqueNameModel>> {
  final BanqueNameApi banqueNameApi = BanqueNameApi();
  final ProfilController profilController = Get.find();

  var banqueNameList = <BanqueNameModel>[].obs;

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

  void clear() {
    nomCompletController.clear();
    rccmController.clear();
    idNatController.clear();
    addresseController.clear();
  }

  void getList() async {
    await banqueNameApi.getAllData().then((response) {
      banqueNameList.assignAll(response);
      change(banqueNameList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await banqueNameApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await banqueNameApi.deleteData(id).then((value) {
        banqueNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprimé avec succès!", "Cet élément a bien été supprimé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submit() async {
    try {
      _isLoading.value = true;
      final dataItem = BanqueNameModel(
          nomComplet: nomCompletController.text.toUpperCase(),
          rccm: (rccmController.text == '') ? '-' : rccmController.text,
          idNat: (idNatController.text == '') ? '-' : idNatController.text,
          addresse:
              (addresseController.text == '') ? '-' : addresseController.text,
          created: DateTime.now());
      await banqueNameApi.insertData(dataItem).then((value) {
        clear();
        banqueNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(BanqueNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = BanqueNameModel(
          id: data.id,
          nomComplet: (nomCompletController.text == '')
              ? data.nomComplet
              : nomCompletController.text.toUpperCase(),
          rccm: (rccmController.text == '') ? data.rccm : rccmController.text,
          idNat:
              (idNatController.text == '') ? data.idNat : idNatController.text,
          addresse: (addresseController.text == '')
              ? data.addresse
              : addresseController.text,
          created: data.created);
      await banqueNameApi.updateData(dataItem).then((value) {
        clear();
        banqueNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
