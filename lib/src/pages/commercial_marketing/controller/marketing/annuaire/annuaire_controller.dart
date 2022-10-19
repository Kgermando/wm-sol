import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wm_solution/src/api/comm_marketing/marketing/annuaire_api.dart';
import 'package:wm_solution/src/models/comm_maketing/annuaire_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class AnnuaireController extends GetxController
    with StateMixin<List<AnnuaireModel>> {
  final AnnuaireApi annuaireApi = AnnuaireApi();
  final ProfilController profilController = Get.find();

  var annuaireList = <AnnuaireModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  bool hasCallSupport = false;
  // ignore: unused_field
  Future<void>? launched;

  TextEditingController nomPostnomPrenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController secteurActiviteController = TextEditingController();
  TextEditingController nomEntrepriseController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController adresseEntrepriseController = TextEditingController();

  String? categorie;

  String query = '';
  Timer? debouncer;

  @override
  void onInit() {
    super.onInit();
    getList();
  }



  @override
  void dispose() {
    debouncer?.cancel();
    nomPostnomPrenomController.dispose();
    emailController.dispose();
    mobile1Controller.dispose();
    mobile2Controller.dispose();
    secteurActiviteController.dispose();
    nomEntrepriseController.dispose();
    gradeController.dispose();
    adresseEntrepriseController.dispose();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    // ignore: deprecated_member_use
    await launch(launchUri.toString());
  }

  void getList() async {
    await annuaireApi.getAllDataSearch(query).then((response) {
      annuaireList.assignAll(response);
      change(annuaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await annuaireApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await annuaireApi.deleteData(id).then((value) {
        annuaireList.clear();
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
      final dataItem = AnnuaireModel(
        categorie: categorie.toString(),
        nomPostnomPrenom: nomPostnomPrenomController.text,
        email: emailController.text,
        mobile1: mobile1Controller.text,
        mobile2: mobile2Controller.text,
        secteurActivite: secteurActiviteController.text,
        nomEntreprise: nomEntrepriseController.text,
        grade: gradeController.text,
        adresseEntreprise: adresseEntrepriseController.text,
        succursale: profilController.user.succursale,
        signature: profilController.user.matricule,
        created: DateTime.now()
      );
      await annuaireApi.insertData(dataItem).then((value) {
        annuaireList.clear();
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

  void submitUpdate(AnnuaireModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = AnnuaireModel(
        id: data.id,
        categorie: categorie.toString(),
        nomPostnomPrenom: nomPostnomPrenomController.text,
        email: emailController.text,
        mobile1: mobile1Controller.text,
        mobile2: mobile2Controller.text,
        secteurActivite: secteurActiviteController.text,
        nomEntreprise: nomEntrepriseController.text,
        grade: gradeController.text,
        adresseEntreprise: adresseEntrepriseController.text,
        succursale: profilController.user.succursale,
        signature: profilController.user.matricule,
        created: data.created
      );
      await annuaireApi.updateData(dataItem).then((value) {
        annuaireList.clear();
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
