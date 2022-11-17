import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/journal_livre_api.dart';
import 'package:wm_solution/src/models/comptabilites/journal_livre_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class JournalLivreController extends GetxController
    with StateMixin<List<JournalLivreModel>> {
  final JournalLivreApi journalLivreApi = JournalLivreApi();
  final ProfilController profilController = Get.find();

  List<JournalLivreModel> journalLivreList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  DateTimeRange? dateRange;
  TextEditingController intituleController = TextEditingController();


  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    intituleController.dispose();
    motifDDController.dispose();
    super.dispose();
  }

  void clear() {
    intituleController.clear();
    motifDDController.clear(); 
  }

  void getList() async {
    await journalLivreApi.getAllData().then((response) {
      journalLivreList.clear();
      journalLivreList.addAll(response);
      change(journalLivreList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await journalLivreApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await journalLivreApi.deleteData(id).then((value) {
        journalLivreList.clear();
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
      final journalLivre = JournalLivreModel(
          intitule: intituleController.text,
          debut: dateRange!.start,
          fin: dateRange!.end,
          isSubmit: 'false',
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await journalLivreApi.insertData(journalLivre).then((value) {
        clear();
        journalLivreList.clear();
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

  void sendDD(JournalLivreModel data) async {
    try {
      _isLoading.value = true;
      final journalLivre = JournalLivreModel(
        id: data.id,
        intitule: data.intitule,
        debut: data.debut,
        fin: data.fin,
        isSubmit: 'true',
        signature: data.signature,
        created: data.created,
        approbationDD: data.approbationDD,
        motifDD: data.motifDD,
        signatureDD: data.signatureDD);
      await journalLivreApi.updateData(journalLivre).then((value) {
        clear();
        journalLivreList.clear();
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

  void submitDD(JournalLivreModel data) async {
    try {
      _isLoading.value = true;
      final journalLivre = JournalLivreModel(
        id: data.id,
        intitule: data.intitule,
        debut: data.debut,
        fin: data.fin,
        isSubmit: data.isSubmit,
        signature: data.signature,
        created: data.created,
        approbationDD: approbationDD,
        motifDD: (motifDDController.text == '') ? '-' : motifDDController.text,
        signatureDD: profilController.user.matricule);
      await journalLivreApi.updateData(journalLivre).then((value) {
        clear();
        journalLivreList.clear();
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
