import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/finances/fin_exterieur_name_api.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_name_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class FinExterieurNameController extends GetxController
    with StateMixin<List<FinExterieurNameModel>> {
  final FinExterieurNameApi finExterieurNameApi = FinExterieurNameApi();
  final ProfilController profilController = Get.find();

  var finExterieurNameList = <FinExterieurNameModel>[].obs;

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
    await finExterieurNameApi.getAllData().then((response) {
      finExterieurNameList.assignAll(response);
      change(finExterieurNameList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await finExterieurNameApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await finExterieurNameApi.deleteData(id).then((value) {
        finExterieurNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Supprim?? avec succ??s!", "Cet ??l??ment a bien ??t?? supprim??",
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
      final dataItem = FinExterieurNameModel(
          nomComplet: nomCompletController.text,
          rccm: (rccmController.text == '') ? '-' : rccmController.text,
          idNat: (idNatController.text == '') ? '-' : idNatController.text,
          addresse:
              (addresseController.text == '') ? '-' : addresseController.text,
          created: DateTime.now());
      await finExterieurNameApi.insertData(dataItem).then((value) {
        clear();
        finExterieurNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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

  void submitUpdate(FinExterieurNameModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = FinExterieurNameModel(
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
      await finExterieurNameApi.updateData(dataItem).then((value) {
        clear();
        finExterieurNameList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectu??e avec succ??s!",
            "Le document a bien ??t?? sauvegad??",
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
