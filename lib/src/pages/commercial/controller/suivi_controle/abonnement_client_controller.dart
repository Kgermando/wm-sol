import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/api/commerciale/suivi_controle/abonnement_client_api.dart';
import 'package:wm_solution/src/api/commerciale/suivi_controle/entreprise_info_api.dart';
import 'package:wm_solution/src/api/upload_file_api.dart';
import 'package:wm_solution/src/models/suivi_controle/abonnement_client_model.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class AbonnementClientController extends GetxController
    with StateMixin<List<AbonnementClientModel>> {
  final AbonnementClientApi abonnementClientApi = AbonnementClientApi();
  final EntrepriseInfoApi entrepriseInfoApi = EntrepriseInfoApi();
  final ProfilController profilController = Get.find();

  List<AbonnementClientModel> abonnementClientList = [];
  List<EntrepriseInfoModel> entrepriseInfoList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  DateTimeRange? dateFinContrat;
  String? typeContrat;
  TextEditingController typeContratController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController signataireContratController = TextEditingController();


  final _isUploading = false.obs;
  bool get isUploading => _isUploading.value;
  final _isUploadingDone = false.obs;
  bool get isUploadingDone => _isUploadingDone.value;

  String? uploadedFileUrl;

  void uploadFile(String file) async {
    _isUploading.value = true;
    await FileApi().uploadFiled(file).then((value) {
      _isUploading.value = false;
      _isUploadingDone.value = true;
      uploadedFileUrl = value;
    });
  }



  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    typeContratController.dispose();
    montantController.dispose();
    signataireContratController.dispose();
    super.dispose();
  }

  void clear() {
    dateFinContrat == null;
    typeContratController.clear();
    montantController.clear();
    signataireContratController.clear();
  }

  void getList() async {
    await abonnementClientApi.getAllData().then((response) {
      abonnementClientList.clear();
      getList();
      abonnementClientList.addAll(response);
      change(abonnementClientList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });

    entrepriseInfoList = await entrepriseInfoApi.getAllData();
  }

  detailView(int id) async {
    final data = await abonnementClientApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await abonnementClientApi.deleteData(id).then((value) {
        clear();
        abonnementClientList.clear();
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

  void submit(EntrepriseInfoModel data) async {
    try {
      _isLoading.value = true;
      final abonnementClient = AbonnementClientModel(
          reference: data.id!,
          dateFinContrat: dateFinContrat!.end,
          typeContrat: typeContrat.toString(),
          montant: montantController.text,
          dateDebutEtFinContrat:
              "${DateFormat("dd-MM-yyyy").format(dateFinContrat!.start)}-${DateFormat("dd-MM-yyyy").format(dateFinContrat!.end)}",
          signataireContrat: signataireContratController.text,
          signature: profilController.user.matricule,
          created: DateTime.now(),
          nomSocial: data.nomSocial,
          scanContrat: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
        );
      await abonnementClientApi.insertData(abonnementClient)
          .then((value) async {
        final dataItem = EntrepriseInfoModel(
          id: data.id,
          nomSocial: data.nomSocial,
          nomGerant: data.nomGerant,
          emailEntreprise: data.emailEntreprise,
          emailGerant: data.emailGerant,
          telephone1: data.telephone1,
          telephone2: data.telephone2,
          rccm: data.rccm,
          identificationNationale: data.identificationNationale,
          numerosImpot: data.numerosImpot,
          secteurActivite: data.secteurActivite,
          adressePhysiqueEntreprise: data.adressePhysiqueEntreprise,
          signature: data.signature,
          created: data.created,
          dateFinContrat: value.dateFinContrat, // Prend la valeur du contrat
          typeContrat: value.typeContrat, // Prend la valeur du contrat
          typeEntreprise: data.typeEntreprise,
        );
        await entrepriseInfoApi.updateData(dataItem).then((value) {
          clear();
          abonnementClientList.clear();
          getList();
          Get.toNamed(ComRoutes.comAbonnements);
          Get.snackbar("Soumission effectuée avec succès!",
              "Le document a bien été sauvegadé",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(AbonnementClientModel abonnement) async {
    try {
      _isLoading.value = true;
      EntrepriseInfoModel data = entrepriseInfoList
          .where((element) =>
              element.id == abonnement.reference &&
              element.nomSocial == abonnement.nomSocial)
          .first;

      final dataItem = AbonnementClientModel(
          id: data.id,
          reference: abonnement.reference,
          dateFinContrat: dateFinContrat!.end,
          typeContrat: typeContratController.text,
          montant: montantController.text,
          dateDebutEtFinContrat:
              "${dateFinContrat!.start}-${dateFinContrat!.end}",
          signataireContrat: signataireContratController.text,
          signature: profilController.user.matricule,
          created: abonnement.created,
          nomSocial: data.nomSocial,
        scanContrat: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
      );
      await abonnementClientApi.updateData(dataItem).then((value) async {
        final dataItem = EntrepriseInfoModel(
          id: data.id,
          nomSocial: data.nomSocial,
          nomGerant: data.nomGerant,
          emailEntreprise: data.emailEntreprise,
          emailGerant: data.emailGerant,
          telephone1: data.telephone1,
          telephone2: data.telephone2,
          rccm: data.rccm,
          identificationNationale: data.identificationNationale,
          numerosImpot: data.numerosImpot,
          secteurActivite: data.secteurActivite,
          adressePhysiqueEntreprise: data.adressePhysiqueEntreprise,
          signature: data.signature,
          created: data.created,
          dateFinContrat: value.dateFinContrat, // Prend la valeur du contrat
          typeContrat: value.typeContrat, // Prend la valeur du contrat
          typeEntreprise: data.typeEntreprise,
        );
        await entrepriseInfoApi.updateData(dataItem).then((value) {
          clear();
          abonnementClientList.clear();
          getList();
          Get.back();
          Get.snackbar("Soumission effectuée avec succès!",
              "Le document a bien été sauvegadé",
              backgroundColor: Colors.green,
              icon: const Icon(Icons.check),
              snackPosition: SnackPosition.TOP);
          _isLoading.value = false;
        });
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
