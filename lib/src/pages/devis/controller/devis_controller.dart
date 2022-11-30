import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/devis/devis_api.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/devis/devis_list_objets_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/priority_dropdown.dart';

class DevisController extends GetxController with StateMixin<List<DevisModel>> {
  final DevisAPi devisAPi = DevisAPi();
  final ProfilController profilController = Get.find();
  final DevisListObjetController devisListObjetController = Get.put(DevisListObjetController());
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());

  List<DevisModel> devisList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final List<String> priorityList = PriorityDropdown().priorityDropdown;
  final TextEditingController titleController = TextEditingController();
  final List<String> departementList = Dropdown().departement;
  String? priority;

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

  List<DevisListObjetsModel> devisObjetList = [];
  List<DepartementBudgetModel> departementsList = [];
  List<LigneBudgetaireModel> ligneBudgetaireList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    titleController.dispose();
    motifDGController.dispose();
    motifBudgetController.dispose();
    motifFinController.dispose();
    motifDDController.dispose();
    super.dispose();
  }

  void clear() {
    titleController.clear();
    motifDGController.clear();
    motifBudgetController.clear();
    motifFinController.clear();
    motifDDController.clear();
  }

  void getList() async {
    devisAPi.getAllData().then((response) {
      devisList.addAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await devisAPi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await devisAPi.deleteData(id).then((value) {
        devisList.clear();
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
      final devisModel = DevisModel(
          title: titleController.text,
          priority: priority.toString(),
          departement: '-',
          observation: 'false',
          signature: profilController.user.matricule,
          createdRef: DateTime.now(),
          created: DateTime.now(),
          isSubmit: 'false',
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
      await devisAPi.insertData(devisModel).then((value) {
        clear();
        devisList.clear();
        getList();
        Get.back();
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été soumis",
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

  void submitObservation(DevisModel data, String obs) async {
    try {
      _isLoading.value = true;
      final devisModel = DevisModel(
          id: data.id!,
          title: data.title,
          priority: data.priority,
          departement: data.departement,
          observation: obs,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: data.isSubmit,
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
      await devisAPi.updateData(devisModel).then((value) {
        clear();
        devisList.clear();
        getList();
        Get.back();
        Get.snackbar("Observation effectuée avec succès!",
            "Le document a bien été soumis",
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

  void sendDD(DevisModel data) async {
    try {
      _isLoading.value = true;
      final devisModel = DevisModel(
          id: data.id!,
          title: data.title,
          priority: data.priority,
          departement: data.departement,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: 'true',
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
      await devisAPi.updateData(devisModel).then((value) {
        clear();
        devisList.clear();
        getList();
        Get.back();
        Get.snackbar("Observation effectuée avec succès!",
            "Le document a bien été soumis",
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

  void submitDG(DevisModel data) async {
    try {
      _isLoading.value = true;
      final devisModel = DevisModel(
        id: data.id!,
        title: data.title,
        priority: data.priority,
        departement: data.departement,
        observation: data.observation,
        signature: data.signature,
        createdRef: data.createdRef,
        created: data.created,
        isSubmit: 'true',
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
      await devisAPi.updateData(devisModel).then((value) {
        clear();
        devisList.clear();
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

  void submitDD(DevisModel data) async {
    try {
      _isLoading.value = true;
      final devisModel = DevisModel(
        id: data.id!,
        title: data.title,
        priority: data.priority,
        departement: data.departement,
        observation: data.observation,
        signature: data.signature,
        createdRef: data.createdRef,
        created: data.created,
        isSubmit: 'true',
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
        motifDD: (motifDDController.text == '') ? '-' : motifDDController.text,
        signatureDD: profilController.user.matricule,
        ligneBudgetaire: '-',
        ressource: '-',
      );
      await devisAPi.updateData(devisModel).then((value) {
        clear();
        devisList.clear();
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

  void submitBudget(DevisModel data) async {
    try {
      _isLoading.value = true;
      final devisModel = DevisModel(
        id: data.id!,
        title: data.title,
        priority: data.priority,
        departement: data.departement,
        observation: data.observation,
        signature: data.signature,
        createdRef: data.createdRef,
        created: data.created,
        isSubmit: 'true',
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
        ligneBudgetaire:
            (ligneBudgtaire.toString() == '') ? '-' : ligneBudgtaire.toString(),
        ressource: (ressource.toString() == '') ? '-' : ressource.toString(),
      );
      await devisAPi.updateData(devisModel).then((value) async {
        double coutTotal = 0.0;
        var transRestAgentList = devisListObjetController
            .devisListObjetList
            .where((p0) => p0.reference == value.id)
            .toList();
        for (var element in transRestAgentList) {
          coutTotal += double.parse(element.montantGlobal);
        }

        var ligneBudget = lignBudgetaireController.ligneBudgetaireList
          .where((element) =>
              element.nomLigneBudgetaire == value.ligneBudgetaire)
          .first;

        if (value.ressource == "caisse") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
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
            caisseSortie: ligneBudget.caisseSortie + coutTotal,
            banqueSortie: ligneBudget.banqueSortie,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi.updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            devisList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegader",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        }
        if (value.ressource == "banque") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
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
                ligneBudget.banqueSortie + coutTotal,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            devisList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegader",
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check),
                snackPosition: SnackPosition.TOP);
            _isLoading.value = false;
          });
        }
        if (value.ressource == "finExterieur") {
          final ligneBudgetaireModel = LigneBudgetaireModel(
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
            finExterieurSortie:
                ligneBudget.finExterieurSortie + coutTotal,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            devisList.clear();
            getList();
            Get.back();
            Get.snackbar(
                "Effectuée avec succès!", "Le document a bien été sauvegader",
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

  Future<void> submitFin(DevisModel data) async {
    try {
      final devisModel = DevisModel(
          id: data.id!,
          title: data.title,
          priority: data.priority,
          departement: data.departement,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          isSubmit: 'true',
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
      await devisAPi.updateData(devisModel).then((value) {
        clear();
        devisList.clear();
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
}
