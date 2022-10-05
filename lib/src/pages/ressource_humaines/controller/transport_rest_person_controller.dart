import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/trans_rest_agents_api.dart'; 
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class TransportRestPersonnelsController extends GetxController
    with StateMixin<List<TransRestAgentsModel>> {
  final TransRestAgentsApi transRestAgentsModel = TransRestAgentsApi();
  final ProfilController profilController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isChecked = false.obs;
  bool get isChecked => _isChecked.value;

  final _isDeleting = false.obs;
  bool get isDeleting => _isDeleting.value; 

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController montantController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    transRestAgentsModel.getAllData().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

   @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    matriculeController.dispose();
    montantController.dispose(); 
    super.dispose();
  }

 

  void submitTransRestAgents(TransportRestaurationModel data) async {
    try {
        _isLoading.value = true; 
      final transRest = TransRestAgentsModel(
          reference: data.createdRef,
          nom: nomController.text,
          prenom: prenomController.text,
          matricule: matriculeController.text,
          montant: montantController.text);
      await transRestAgentsModel.insertData(transRest).then((value) {
        Get.back();
        Get.snackbar("Ajouté avec succès!",
            "${nomController.text} a bien été ajouté",
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
 
