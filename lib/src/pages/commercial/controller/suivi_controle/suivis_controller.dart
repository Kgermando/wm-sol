import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/suivi_controle/suivis_api.dart';
import 'package:wm_solution/src/models/suivi_controle/suivi_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class SuivisController extends GetxController
    with StateMixin<List<SuiviModel>> {
  final SuivisApi suivisApi = SuivisApi();
  final ProfilController profilController = Get.find();

  List<SuiviModel> suivisList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? nomSocial;
  TextEditingController travailEffectueController = TextEditingController();
  TextEditingController accuseeReceptionController = TextEditingController();
  String? background;
  String? eventName;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    travailEffectueController.dispose();
    accuseeReceptionController.dispose();
    super.dispose();
  }

  void clear() {
    nomSocial == null;
    travailEffectueController.clear();
    accuseeReceptionController.clear();
  }

  void getList() async {
    await suivisApi.getAllData().then((response) {
      suivisList.clear();
      getList();
      suivisList.addAll(response);
      change(suivisList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await suivisApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await suivisApi.deleteData(id).then((value) {
        clear();
        suivisList.clear();
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

  void submit(DateTime date) async {
    try {
      _isLoading.value = true;
      final dataItem = SuiviModel(
        nomSocial: nomSocial.toString(),
        travailEffectue: travailEffectueController.text,
        accuseeReception: accuseeReceptionController.text,
        signature: profilController.user.matricule,
        created: DateTime.now(),
        createdDay: date,
        background: background.toString(),
        eventName: eventName.toString()
      );
      await suivisApi.insertData(dataItem).then((value) {
        clear();
        suivisList.clear();
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

  void submitUpdate(SuiviModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = SuiviModel(
        nomSocial: data.nomSocial,
        travailEffectue: travailEffectueController.text,
        accuseeReception: accuseeReceptionController.text,
        signature: profilController.user.matricule,
        created: data.created,
        createdDay: data.createdDay,
        background: background.toString(),
        eventName: eventName.toString()
      );
      await suivisApi.updateData(dataItem).then((value) {
        clear();
        suivisList.clear();
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
