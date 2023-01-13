import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/commerciale/suivi_controle/entreprise_info_api.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class EntrepriseInfosController extends GetxController
    with StateMixin<List<EntrepriseInfoModel>> {
  final EntrepriseInfoApi entrepriseInfoApi = EntrepriseInfoApi();
  final ProfilController profilController = Get.find();

  List<EntrepriseInfoModel> entrepriseInfosList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomSocialController = TextEditingController();
  TextEditingController nomGerantController = TextEditingController();
  TextEditingController emailEntrepriseController = TextEditingController();
  TextEditingController emailGerantController = TextEditingController();
  TextEditingController telephone1Controller = TextEditingController();
  TextEditingController telephone2Controller = TextEditingController();
  TextEditingController rccmController = TextEditingController();
  TextEditingController identificationNationaleController =
      TextEditingController();
  TextEditingController numerosImpotController = TextEditingController();
  TextEditingController secteurActiviteController = TextEditingController();
  TextEditingController adressePhysiqueEntrepriseController =
      TextEditingController();
  String? typeEntreprise;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    nomSocialController.dispose();
    nomGerantController.dispose();
    emailEntrepriseController.dispose();
    emailGerantController.dispose();
    telephone1Controller.dispose();
    telephone2Controller.dispose();
    rccmController.dispose();
    identificationNationaleController.dispose();
    numerosImpotController.dispose();
    secteurActiviteController.dispose();
    adressePhysiqueEntrepriseController.dispose();

    super.dispose();
  }

  void clear() {
    nomSocialController.clear();
    nomGerantController.clear();
    emailEntrepriseController.clear();
    emailGerantController.clear();
    telephone1Controller.clear();
    telephone2Controller.clear();
    rccmController.clear();
    identificationNationaleController.clear();
    numerosImpotController.clear();
    secteurActiviteController.clear();
    adressePhysiqueEntrepriseController.clear();
    typeEntreprise == null;
  }

  void getList() async {
    await entrepriseInfoApi.getAllData().then((response) {
      entrepriseInfosList.clear();
      getList();
      entrepriseInfosList.addAll(response);
      change(entrepriseInfosList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await entrepriseInfoApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await entrepriseInfoApi.deleteData(id).then((value) {
        clear();
        entrepriseInfosList.clear();
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
      final dataItem = EntrepriseInfoModel(
        nomSocial: (nomSocialController.text == '') ? '-' : nomSocialController.text,
        nomGerant: (nomGerantController.text == '') ? '-' : nomGerantController.text,
        emailEntreprise: (emailEntrepriseController.text == '')
            ? '-'
            :  emailEntrepriseController.text,
        emailGerant:
            (emailGerantController.text == '') ? '-' :  emailGerantController.text,
        telephone1:(telephone1Controller.text == '') ? '-' :  telephone1Controller.text,
        telephone2:(telephone2Controller.text == '') ? '-' :  telephone2Controller.text,
        rccm:(rccmController.text == '') ? '-' :  rccmController.text,
        identificationNationale:(identificationNationaleController.text == '') ? '-' :  identificationNationaleController.text,
        numerosImpot: (numerosImpotController.text == '')
            ? '-'
            :  numerosImpotController.text,
        secteurActivite: (secteurActiviteController.text == '')
            ? '-'
            :  secteurActiviteController.text,
        adressePhysiqueEntreprise: (adressePhysiqueEntrepriseController.text == '')
            ? '-'
            :  adressePhysiqueEntrepriseController.text,
        signature: profilController.user.matricule,
        created: DateTime.now(),
        dateFinContrat: DateTime.parse("2100-12-31 00:00:00.000000"),
        typeContrat: '-', // Depend de l'abonnement
        typeEntreprise: typeEntreprise.toString(),
      );
      await entrepriseInfoApi.insertData(dataItem).then((value) {
        clear();
        entrepriseInfosList.clear();
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

  void submitUpdate(EntrepriseInfoModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = EntrepriseInfoModel(
        id: data.id,
        nomSocial:
            (nomSocialController.text == '') ? data.nomSocial : nomSocialController.text,
        nomGerant:
            (nomGerantController.text == '') ? data.nomGerant : nomGerantController.text,
        emailEntreprise: (emailEntrepriseController.text == '')
            ? data.emailEntreprise
            : emailEntrepriseController.text,
        emailGerant: (emailGerantController.text == '')
            ? data.emailGerant
            : emailGerantController.text,
        telephone1:
            (telephone1Controller.text == '') ? data.telephone1 : telephone1Controller.text,
        telephone2:
            (telephone2Controller.text == '') ? data.telephone2 : telephone2Controller.text,
        rccm: (rccmController.text == '') ? data.rccm : rccmController.text,
        identificationNationale: (identificationNationaleController.text == '')
            ? data.identificationNationale
            : identificationNationaleController.text,
        numerosImpot: (numerosImpotController.text == '')
            ? data.numerosImpot
            : numerosImpotController.text,
        secteurActivite: (secteurActiviteController.text == '')
            ? data.secteurActivite
            : secteurActiviteController.text,
        adressePhysiqueEntreprise:
            (adressePhysiqueEntrepriseController.text == '')
                ? data.adressePhysiqueEntreprise
                : adressePhysiqueEntrepriseController.text,
        signature: profilController.user.matricule,
        created: data.created,
        dateFinContrat: data.dateFinContrat,
        typeContrat: '-',
        typeEntreprise: typeEntreprise.toString(),
      );
      await entrepriseInfoApi.updateData(dataItem).then((value) {
        clear();
        entrepriseInfosList.clear();
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
