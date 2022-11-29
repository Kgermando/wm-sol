import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/budgets/ligne_budgetaire_api.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class LignBudgetaireController extends GetxController
    with StateMixin<List<LigneBudgetaireModel>> {
  LIgneBudgetaireApi lIgneBudgetaireApi = LIgneBudgetaireApi();
  final ProfilController profilController = Get.find();
  final CampaignController campaignController = Get.find();
  final DevisController devisController = Get.find();
  final DevisListObjetController devisListObjetController = Get.find();
  final ProjetController projetController = Get.find();
  final SalaireController salaireController = Get.find();
  final TransportRestController transportRestController = Get.find();
  final TransportRestPersonnelsController transportRestPersonnelsController =
      Get.find();

  List<LigneBudgetaireModel> ligneBudgetaireList =  [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  TextEditingController nomLigneBudgetaireController = TextEditingController();
  TextEditingController uniteChoisieController = TextEditingController();
  double nombreUniteController = 0.0;
  double coutUnitaireController = 0.0;
  double caisseController = 0.0;
  double banqueController = 0.0;

  List<CampaignModel> dataCampaignList = [];
  List<DevisModel> dataDevisList = [];
  List<DevisListObjetsModel> devisListObjetsList = []; // avec montant
  List<ProjetModel> dataProjetList = [];
  List<PaiementSalaireModel> dataSalaireList = [];
  List<TransportRestaurationModel> dataTransRestList = [];
  List<TransRestAgentsModel> tansRestList = []; // avec montant

  @override
  void onInit() {
    super.onInit();
    getList();

    devisListObjetsList = devisListObjetController.devisListObjetList;
    tansRestList = transportRestPersonnelsController.transRestAgentList;
    dataCampaignList = campaignController.campaignList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == '-')
        .toList();
    dataDevisList = devisController.devisList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == '-')
        .toList();
    dataProjetList = projetController.projetList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == '-')
        .toList();
    dataSalaireList = salaireController.paiementSalaireList
        .where((element) =>
            element.createdAt.month == DateTime.now().month &&
            element.createdAt.year == DateTime.now().year &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == '-')
        .toList();
    dataTransRestList = transportRestController.transportRestaurationList
        .where((element) =>
            element.approbationDG == 'Approved' &&
            element.approbationDD == 'Approved' &&
            element.approbationBudget == '-')
        .toList();
  }

  @override
  void dispose() {
    nomLigneBudgetaireController.dispose();
    uniteChoisieController.dispose();

    super.dispose();
  }

  void getList() async {
    await lIgneBudgetaireApi.getAllData().then((response) {
      ligneBudgetaireList.assignAll(response);

      change(ligneBudgetaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await lIgneBudgetaireApi.getOneData(id);
    return data;
  }

  deleteData(int id) async {
    try {
      _isLoading.value = true;
      await lIgneBudgetaireApi.deleteData(id).then((value) {
        ligneBudgetaireList.clear();
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

  void submit(DepartementBudgetModel data) async {
    final coutToal = nombreUniteController * coutUnitaireController;
    final fonds = caisseController + banqueController;
    final fondsAtrouver = coutToal - fonds;
    try {
      _isLoading.value = true;
      final ligneBudgetaireModel = LigneBudgetaireModel(
          nomLigneBudgetaire: nomLigneBudgetaireController.text,
          departement: data.departement,
          periodeBudgetDebut: data.periodeDebut,
          periodeBudgetFin: data.periodeFin,
          uniteChoisie: uniteChoisieController.text,
          nombreUnite: nombreUniteController.toString(),
          coutUnitaire: coutUnitaireController.toString(),
          coutTotal: coutToal.toString(),
          caisse: caisseController.toString(),
          banque: banqueController.toString(),
          finExterieur: fondsAtrouver.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now(), 
          reference: data.id!);
      await lIgneBudgetaireApi.insertData(ligneBudgetaireModel).then((value) {
        ligneBudgetaireList.clear();
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
