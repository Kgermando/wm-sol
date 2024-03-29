import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/exploitations/agent_role_api.dart';
import 'package:wm_solution/src/models/exploitations/agent_role_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class PersonnelsRolesController extends GetxController
    with StateMixin<List<AgentRoleModel>> {
  final AgentRoleApi personnelsRoleApi = AgentRoleApi();
  final ProfilController profilController = Get.find();

  RxList<AgentRoleModel> personnelsRoleList = <AgentRoleModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  String? agentController;
  TextEditingController roleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    roleController.dispose();
    super.dispose();
  }

  void clear() {
    agentController == null;
    roleController.clear();
  }

  void getList() async {
    await personnelsRoleApi.getAllData().then((response) {
      personnelsRoleList.clear();
      personnelsRoleList.assignAll(response);
      change(personnelsRoleList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await personnelsRoleApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await personnelsRoleApi.deleteData(id).then((value) {
        personnelsRoleList.clear();
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

  void submit(int id, String departement) async {
    try {
      _isLoading.value = true;
      final dataItem = AgentRoleModel(
          reference: id,
          departement: departement,
          agent: agentController.toString(),
          role: roleController.text,
          created: DateTime.now());
      await personnelsRoleApi.insertData(dataItem).then((value) {
        clear();
        personnelsRoleList.clear();
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

  void submitUpdate(AgentRoleModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = AgentRoleModel(
          reference: data.reference,
          departement: data.departement,
          agent: agentController.toString(),
          role: roleController.text,
          created: data.created);
      await personnelsRoleApi.updateData(dataItem).then((value) {
        clear();
        personnelsRoleList.clear();
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
