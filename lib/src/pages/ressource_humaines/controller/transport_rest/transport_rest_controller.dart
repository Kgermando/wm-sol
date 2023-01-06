import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/transport_restaurant_api.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class TransportRestController extends GetxController
    with StateMixin<List<TransportRestaurationModel>> {
  final TransportRestaurationApi transportRestaurationApi =
      TransportRestaurationApi();
  final ProfilController profilController = Get.find();
  final TransportRestPersonnelsController transportRestPersonnelsController =
      Get.put(TransportRestPersonnelsController());
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());

  List<TransportRestaurationModel> transportRestaurationList = [] ;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController titleController = TextEditingController();

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
  }

  @override
  void dispose() {
    super.dispose();
    motifDGController.dispose();
    motifBudgetController.dispose();
    motifFinController.dispose();
    motifDDController.dispose();
  }

  void clear() {
    ligneBudgtaire = null;
    ressource = null;
    motifDGController.clear();
    motifBudgetController.clear();
    motifFinController.clear();
    motifDDController.clear();
  }

  void getList() async {
    await transportRestaurationApi.getAllData().then((response) {
      transportRestaurationList.clear();
      transportRestaurationList.addAll(response);
      change(transportRestaurationList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await transportRestaurationApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await transportRestaurationApi.deleteData(id).then((value) {
        transportRestaurationList.clear();
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
        clear(); 
        Get.toNamed(RhRoutes.rhTransportRest);
        Get.snackbar("Soumission effectuée avec succès!",
            "Le document a bien été sauvegadé",
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
          observation: data.observation,
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
        clear();
        transportRestaurationList.clear();
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
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitObservation(TransportRestaurationModel data) async {
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
          isSubmit: data.isSubmit);
      await transportRestaurationApi.updateData(transRest).then((value) {
        clear();
        transportRestaurationList.clear();
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

  void submitDG(TransportRestaurationModel data) async {
    try {
      _isLoading.value = true;
      final transRest = TransportRestaurationModel(
          id: data.id!,
          title: data.title,
          observation: data.observation,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          approbationDG: approbationDG,
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
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
          isSubmit: data.isSubmit);
      await transportRestaurationApi.updateData(transRest).then((value) {
        clear();
        transportRestaurationList.clear();
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

  void submitDD(TransportRestaurationModel data) async {
    try {
      _isLoading.value = true;
      final transRest = TransportRestaurationModel(
          id: data.id!,
          title: data.title,
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
          ressource: '-',
          isSubmit: data.isSubmit);
      await transportRestaurationApi.updateData(transRest).then((value) {
        clear();
        transportRestaurationList.clear();
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

  void submitBudget(TransportRestaurationModel data) async {
    try {
      _isLoading.value = true;
      final transRest = TransportRestaurationModel(
          id: data.id!,
          title: data.title,
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
          ressource: (ressource.toString() == '') ? '-' : ressource.toString(),
          isSubmit: data.isSubmit);
      await transportRestaurationApi.updateData(transRest).then((value) async {
        double coutTotal = 0.0;
        var transRestAgentList = transportRestPersonnelsController
            .transRestAgentList
            .where((p0) => p0.reference == value.id)
            .toList();
        for (var element in transRestAgentList) {
          coutTotal += double.parse(element.montant);
        }

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
            caisseSortie: ligneBudget.caisseSortie + coutTotal,
            banqueSortie: ligneBudget.banqueSortie,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            transportRestaurationList.clear();
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
            banqueSortie: ligneBudget.banqueSortie + coutTotal,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            transportRestaurationList.clear();
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
            finExterieurSortie: ligneBudget.finExterieurSortie + coutTotal,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            transportRestaurationList.clear();
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
      _isLoading.value = false;
      Get.snackbar("Erreur lors de la soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> submitFin(TransportRestaurationModel data) async {
    try {
      _isLoading.value = true;
      final transRest = TransportRestaurationModel(
          id: data.id!,
          title: data.title,
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
          ressource: data.ressource,
          isSubmit: data.isSubmit);
      await transportRestaurationApi.updateData(transRest).then((value) {
        clear();
        transportRestaurationList.clear();
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
