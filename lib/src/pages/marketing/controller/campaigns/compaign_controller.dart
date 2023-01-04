import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/api/marketing/campaign_api.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';

class CampaignController extends GetxController
    with StateMixin<List<CampaignModel>> {
  final CampaignApi campaignApi = CampaignApi();
  final ProfilController profilController = Get.find();
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());

  List<CampaignModel> campaignList = [];

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

  void clear() {
    ligneBudgtaire = null;
    ressource = null;
    typeProduitController.clear();
    dateDebutEtFinController.clear();
    coutCampaignController.clear();
    lieuCibleController.clear();
    promotionController.clear();
    objectifsController.clear();

    motifDGController.clear();
    motifBudgetController.clear();
    motifFinController.clear();
    motifDDController.clear();
  }

  void getList() async {
    campaignApi.getAllData().then((response) {
      campaignList.addAll(response);
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
          isSubmit: "false",
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
        clear();
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

  void submitUpdate(CampaignModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = CampaignModel(
          id: data.id!,
          typeProduit: typeProduitController.text,
          dateDebutEtFin:
              "Du ${DateFormat('dd/MM/yyyy').format(dateRange!.start)} - Au ${DateFormat('dd/MM/yyyy').format(dateRange!.end)}",
          coutCampaign: coutCampaignController.text,
          lieuCible: lieuCibleController.text,
          promotion: promotionController.text,
          objectifs: objectifsController.text,
          observation: 'false',
          signature: profilController.user.matricule.toString(),
          isSubmit: 'false',
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
        clear();
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
          isSubmit: data.isSubmit,
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
        clear();
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

  void submitToDD(CampaignModel data) async {
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
          isSubmit: 'true',
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
        clear();
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
        isSubmit: data.isSubmit,
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
        clear();
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
          isSubmit: data.isSubmit,
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
        clear();
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
          isSubmit: data.isSubmit,
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
      await campaignApi.updateData(dataItem).then((value) async {
        var ligneBudget = lignBudgetaireController.ligneBudgetaireList
            .where((element) =>
                element.nomLigneBudgetaire == value.ligneBudgetaire)
            .first;

        if (value.ressource == "caisse") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
            id: ligneBudget.id,
            nomLigneBudgetaire: ligneBudget.nomLigneBudgetaire,
            departement: ligneBudget.departement,
            periodeBudgetDebut: ligneBudget.periodeBudgetDebut,
            periodeBudgetFin: ligneBudget.periodeBudgetFin,
            uniteChoisie: ligneBudget.uniteChoisie,
            nombreUnite: ligneBudget.nombreUnite,
            coutUnitaire: ligneBudget.coutUnitaire,
            coutTotal: ligneBudget.coutTotal,
            caisse: ligneBudget.caisse,
            banque: ligneBudget.banque,
            finExterieur: ligneBudget.finExterieur,
            signature: ligneBudget.signature,
            created: ligneBudget.created,
            reference: ligneBudget.reference,
            caisseSortie:
                ligneBudget.caisseSortie + double.parse(value.coutCampaign),
            banqueSortie: ligneBudget.banqueSortie,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            campaignList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegadé",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        }
        if (value.ressource == "banque") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
            id: ligneBudget.id,
            nomLigneBudgetaire: ligneBudget.nomLigneBudgetaire,
            departement: ligneBudget.departement,
            periodeBudgetDebut: ligneBudget.periodeBudgetDebut,
            periodeBudgetFin: ligneBudget.periodeBudgetFin,
            uniteChoisie: ligneBudget.uniteChoisie,
            nombreUnite: ligneBudget.nombreUnite,
            coutUnitaire: ligneBudget.coutUnitaire,
            coutTotal: ligneBudget.coutTotal,
            caisse: ligneBudget.caisse,
            banque: ligneBudget.banque,
            finExterieur: ligneBudget.finExterieur,
            signature: ligneBudget.signature,
            created: ligneBudget.created,
            reference: ligneBudget.reference,
            caisseSortie: ligneBudget.caisseSortie,
            banqueSortie:
                ligneBudget.banqueSortie + double.parse(value.coutCampaign),
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            campaignList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegadé",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        }
        if (value.ressource == "finExterieur") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
            id: ligneBudget.id,
            nomLigneBudgetaire: ligneBudget.nomLigneBudgetaire,
            departement: ligneBudget.departement,
            periodeBudgetDebut: ligneBudget.periodeBudgetDebut,
            periodeBudgetFin: ligneBudget.periodeBudgetFin,
            uniteChoisie: ligneBudget.uniteChoisie,
            nombreUnite: ligneBudget.nombreUnite,
            coutUnitaire: ligneBudget.coutUnitaire,
            coutTotal: ligneBudget.coutTotal,
            caisse: ligneBudget.caisse,
            banque: ligneBudget.banque,
            finExterieur: ligneBudget.finExterieur,
            signature: ligneBudget.signature,
            created: ligneBudget.created,
            reference: ligneBudget.reference,
            caisseSortie: ligneBudget.caisseSortie,
            banqueSortie: ligneBudget.banqueSortie,
            finExterieurSortie: ligneBudget.finExterieurSortie +
                double.parse(value.coutCampaign),
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            campaignList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegadé",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        }
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
          isSubmit: data.isSubmit,
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
        clear();
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
