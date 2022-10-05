import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/transport_restaurant_api.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TransportRestController extends GetxController
    with StateMixin<List<TransportRestaurationModel>> {
  final TransportRestaurationApi transportRestaurationApi =
      TransportRestaurationApi();
  final ProfilController profilController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController titleController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    transportRestaurationApi.getAllData().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await transportRestaurationApi.getOneData(id);
    return data;
  }



  void submit() async {
    try {
      _isLoading.value = true; 
      final transRest = TransportRestaurationModel(
          title: titleController.text,
          observation: 'false',
          signature: profilController.user.matricule.toString(),
          createdRef: DateTime.now(),
          created: DateTime.now(),
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationBudget: '-',
          motifBudget: '-',
          signatureBudget: '-',
          approbationFin: '-',
          motifFin: '-',
          signatureFin: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-',
          ligneBudgetaire: '-',
          ressource: '-',
          isSubmit: 'false');
      await transportRestaurationApi.insertData(transRest).then((value) {
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


  void sendDD(TransportRestaurationModel data) async {
    try {
      _isLoading.value = true; 
      final transRest = TransportRestaurationModel(
          id: data.id!,
          title: data.title,
          observation: 'true',
          signature: data.signature,
          createdRef: data.createdRef,
          created: DateTime.now(),
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationBudget: data.approbationBudget,
          motifBudget: data.motifBudget,
          signatureBudget: data.signatureBudget,
          approbationFin: data.approbationFin,
          motifFin: data.motifFin,
          signatureFin: data.signatureFin,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD,
          ligneBudgetaire: data.ligneBudgetaire,
          ressource: data.ressource,
          isSubmit: 'true');
      await transportRestaurationApi.updateData(transRest).then((value) {
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
 
