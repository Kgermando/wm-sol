import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/api/marketing/campaign_api.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class CampaignController extends GetxController
    with StateMixin<List<CampaignModel>> {
  final CampaignApi campaignApi = CampaignApi();
  final ProfilController profilController = Get.put(ProfilController());

  var campaignList = <CampaignModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  DateTimeRange? dateRange;

  TextEditingController typeProduitController = TextEditingController();
  TextEditingController dateDebutEtFinController = TextEditingController();
  TextEditingController coutCampaignController = TextEditingController();
  TextEditingController lieuCibleController = TextEditingController();
  TextEditingController promotionController = TextEditingController();
  TextEditingController objectifsController = TextEditingController();

  String getPlageDate() {
    if (dateRange == null) {
      return 'Date de Debut et Fin';
    } else {
      return '${DateFormat('dd/MM/yyyy').format(dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(dateRange!.end)}';
    }
  }

  // Approbations
  final formKeyBudget = GlobalKey<FormState>();

  String approbationDG = '-';
  String approbationBudget = '-';
  String approbationFin = '-';
  String approbationDD = '-';
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifBudgetController = TextEditingController();
  TextEditingController motifFinController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();
  String? ligneBudgtaire;
  String? ressource;

  @override
  void onInit() {
    super.onInit();
    getList();
    getPlageDate();
  }

  @override
  void dispose() {
    super.dispose();
    typeProduitController.dispose();
    dateDebutEtFinController.dispose();
    coutCampaignController.dispose();
    lieuCibleController.dispose();
    promotionController.dispose();
    objectifsController.dispose();

    motifDGController.dispose();
    motifBudgetController.dispose();
    motifFinController.dispose();
    motifDDController.dispose();
  }

  void getList() async {
    campaignApi.getAllData().then((response) {
      campaignList.assignAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await campaignApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await campaignApi.deleteData(id).then((value) {
        campaignList.clear();
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
      final dataItem = CampaignModel(
          typeProduit: typeProduitController.text,
          dateDebutEtFin:
              "Du ${DateFormat('dd/MM/yyyy').format(dateRange!.start)} - Au ${DateFormat('dd/MM/yyyy').format(dateRange!.end)}",
          coutCampaign: coutCampaignController.text,
          lieuCible: lieuCibleController.text,
          promotion: promotionController.text,
          objectifs: objectifsController.text,
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
          ressource: '-');
      await campaignApi.insertData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitObservation(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
          id: data.id!,
          typeProduit: data.typeProduit,
          dateDebutEtFin: data.dateDebutEtFin,
          coutCampaign: data.coutCampaign,
          lieuCible: data.lieuCible,
          promotion: data.promotion,
          objectifs: data.objectifs,
          observation: 'true',
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
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
          ressource: data.ressource);
      await campaignApi.updateData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitDG(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
        id: data.id!,
        typeProduit: data.typeProduit,
        dateDebutEtFin: data.dateDebutEtFin,
        coutCampaign: data.coutCampaign,
        lieuCible: data.lieuCible,
        promotion: data.promotion,
        objectifs: data.objectifs,
        observation: data.observation,
        signature: data.signature,
        createdRef: data.createdRef,
        created: data.created,
        approbationDG: approbationDG,
        motifDG: (motifDGController.text == '') ? '-' : motifDGController.text,
        signatureDG: profilController.user.matricule,
        approbationBudget: '-',
        motifBudget: '-',
        signatureBudget: '-',
        approbationFin: '-',
        motifFin: '-',
        signatureFin: '-',
        approbationDD: data.approbationDD,
        motifDD: data.motifDD,
        signatureDD: data.signatureDD,
        ligneBudgetaire: '-',
        ressource: '-',
      );
      await campaignApi.updateData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitDD(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
          id: data.id!,
          typeProduit: data.typeProduit,
          dateDebutEtFin: data.dateDebutEtFin,
          coutCampaign: data.coutCampaign,
          lieuCible: data.lieuCible,
          promotion: data.promotion,
          objectifs: data.objectifs,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationBudget: '-',
          motifBudget: '-',
          signatureBudget: '-',
          approbationFin: '-',
          motifFin: '-',
          signatureFin: '-',
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule,
          ligneBudgetaire: '-',
          ressource: '-');
      await campaignApi.updateData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitBudget(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
          id: data.id!,
          typeProduit: data.typeProduit,
          dateDebutEtFin: data.dateDebutEtFin,
          coutCampaign: data.coutCampaign,
          lieuCible: data.lieuCible,
          promotion: data.promotion,
          objectifs: data.objectifs,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationBudget: approbationBudget,
          motifBudget: (motifBudgetController.text == '')
              ? '-'
              : motifBudgetController.text,
          signatureBudget: profilController.user.matricule,
          approbationFin: '-',
          motifFin: '-',
          signatureFin: '-',
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD,
          ligneBudgetaire: (ligneBudgtaire.toString() == '')
              ? '-'
              : ligneBudgtaire.toString(),
          ressource: (ressource.toString() == '') ? '-' : ressource.toString());
      await campaignApi.updateData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> submitFin(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
          id: data.id!,
          typeProduit: data.typeProduit,
          dateDebutEtFin: data.dateDebutEtFin,
          coutCampaign: data.coutCampaign,
          lieuCible: data.lieuCible,
          promotion: data.promotion,
          objectifs: data.objectifs,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          approbationDG: data.approbationDG,
          motifDG: data.motifDG,
          signatureDG: data.signatureDG,
          approbationBudget: data.approbationBudget,
          motifBudget: data.motifBudget,
          signatureBudget: data.signatureBudget,
          approbationFin: approbationFin,
          motifFin:
              (motifFinController.text == '') ? '-' : motifFinController.text,
          signatureFin: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD,
          ligneBudgetaire: data.ligneBudgetaire,
          ressource: data.ressource);
      await campaignApi.updateData(dataItem).then((value) {
        campaignList.clear();
        getList();
        Get.back();
        Get.snackbar("Effectuée avec succès!", "Le document a bien été soumis",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        _isLoading.value = false;
      });
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }
}
