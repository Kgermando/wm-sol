import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/comptabilite/compte_resultat_api.dart';
import 'package:wm_solution/src/models/comptabilites/compte_resultat_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class CompteResultatController extends GetxController
    with StateMixin<List<CompteResulatsModel>> {
  final CompteResultatApi compteResultatApi = CompteResultatApi();
  final ProfilController profilController = Get.put(ProfilController());

  var compteResultatList = <CompteResulatsModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Approbations
  final formKeyBudget = GlobalKey<FormState>();

  String approbationDG = '-';
  String approbationDD = '-';
  TextEditingController motifDDController = TextEditingController();

  TextEditingController intituleController = TextEditingController();
  TextEditingController achatMarchandisesController = TextEditingController();
  TextEditingController variationStockMarchandisesController =
      TextEditingController();
  TextEditingController achatApprovionnementsController =
      TextEditingController();
  TextEditingController variationApprovionnementsController =
      TextEditingController();
  TextEditingController autresChargesExterneController =
      TextEditingController();
  TextEditingController impotsTaxesVersementsAssimilesController =
      TextEditingController();
  TextEditingController renumerationPersonnelController =
      TextEditingController();
  TextEditingController chargesSocialasController = TextEditingController();
  TextEditingController dotatiopnsProvisionsController =
      TextEditingController();
  TextEditingController autresChargesController = TextEditingController();
  TextEditingController chargesfinancieresController = TextEditingController();
  TextEditingController chargesExptionnellesController =
      TextEditingController();
  TextEditingController impotSurbeneficesController = TextEditingController();
  TextEditingController soldeCrediteurController = TextEditingController();
  TextEditingController ventesMarchandisesController = TextEditingController();

  TextEditingController productionVendueBienEtSericesController =
      TextEditingController();
  TextEditingController productionStockeeController = TextEditingController();
  TextEditingController productionImmobiliseeController =
      TextEditingController();
  TextEditingController subventionExploitationController =
      TextEditingController();
  TextEditingController autreProduitsController = TextEditingController();
  TextEditingController montantExportationController = TextEditingController();
  TextEditingController produitfinancieresController = TextEditingController();
  TextEditingController produitExceptionnelsController =
      TextEditingController();
  TextEditingController soldeDebiteurController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDDController.dispose();

    intituleController.dispose();
    achatMarchandisesController.dispose();
    variationStockMarchandisesController.dispose();
    achatApprovionnementsController.dispose();
    variationApprovionnementsController.dispose();
    autresChargesExterneController.dispose();
    impotsTaxesVersementsAssimilesController.dispose();
    renumerationPersonnelController.dispose();
    chargesSocialasController.dispose();
    dotatiopnsProvisionsController.dispose();
    autresChargesController.dispose();
    chargesfinancieresController.dispose();
    chargesExptionnellesController.dispose();
    impotSurbeneficesController.dispose();
    soldeCrediteurController.dispose();
    ventesMarchandisesController.dispose();
    productionVendueBienEtSericesController.dispose();
    productionStockeeController.dispose();
    productionImmobiliseeController.dispose();
    subventionExploitationController.dispose();
    autreProduitsController.dispose();
    montantExportationController.dispose();
    produitfinancieresController.dispose();
    produitExceptionnelsController.dispose();
    soldeDebiteurController.dispose();

    super.dispose();
  }

  void getList() async {
    await compteResultatApi.getAllData().then((response) {
      compteResultatList.assignAll(response);
      change(compteResultatList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await compteResultatApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await compteResultatApi.deleteData(id).then((value) {
        compteResultatList.clear();
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
      final compteResulatsModel = CompteResulatsModel(
          intitule: intituleController.text,
          achatMarchandises: achatMarchandisesController.text,
          variationStockMarchandises: variationStockMarchandisesController.text,
          achatApprovionnements: achatApprovionnementsController.text,
          variationApprovionnements: variationApprovionnementsController.text,
          autresChargesExterne: autresChargesExterneController.text,
          impotsTaxesVersementsAssimiles:
              impotsTaxesVersementsAssimilesController.text,
          renumerationPersonnel: renumerationPersonnelController.text,
          chargesSocialas: chargesSocialasController.text,
          dotatiopnsProvisions: dotatiopnsProvisionsController.text,
          autresCharges: autresChargesController.text,
          chargesfinancieres: chargesfinancieresController.text,
          chargesExptionnelles: chargesExptionnellesController.text,
          impotSurbenefices: impotSurbeneficesController.text,
          soldeCrediteur: soldeCrediteurController.text,
          ventesMarchandises: ventesMarchandisesController.text,
          productionVendueBienEtSerices:
              productionVendueBienEtSericesController.text,
          productionStockee: productionStockeeController.text,
          productionImmobilisee: productionImmobiliseeController.text,
          subventionExploitation: subventionExploitationController.text,
          autreProduits: autreProduitsController.text,
          montantExportation: montantExportationController.text,
          produitfinancieres: produitfinancieresController.text,
          produitExceptionnels: produitExceptionnelsController.text,
          soldeDebiteur: soldeDebiteurController.text,
          signature: profilController.user.matricule.toString(),
          createdRef: DateTime.now(),
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await compteResultatApi.insertData(compteResulatsModel).then((value) {
        compteResultatList.clear();
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

  void submitUpdate(CompteResulatsModel data) async {
    try {
      _isLoading.value = true;
      final compteResulatsModel = CompteResulatsModel(
          id: data.id,
          intitule: intituleController.text,
          achatMarchandises: achatMarchandisesController.text,
          variationStockMarchandises: variationStockMarchandisesController.text,
          achatApprovionnements: achatApprovionnementsController.text,
          variationApprovionnements: variationApprovionnementsController.text,
          autresChargesExterne: autresChargesExterneController.text,
          impotsTaxesVersementsAssimiles:
              impotsTaxesVersementsAssimilesController.text,
          renumerationPersonnel: renumerationPersonnelController.text,
          chargesSocialas: chargesSocialasController.text,
          dotatiopnsProvisions: dotatiopnsProvisionsController.text,
          autresCharges: autresChargesController.text,
          chargesfinancieres: chargesfinancieresController.text,
          chargesExptionnelles: chargesExptionnellesController.text,
          impotSurbenefices: impotSurbeneficesController.text,
          soldeCrediteur: soldeCrediteurController.text,
          ventesMarchandises: ventesMarchandisesController.text,
          productionVendueBienEtSerices:
              productionVendueBienEtSericesController.text,
          productionStockee: productionStockeeController.text,
          productionImmobilisee: productionImmobiliseeController.text,
          subventionExploitation: subventionExploitationController.text,
          autreProduits: autreProduitsController.text,
          montantExportation: montantExportationController.text,
          produitfinancieres: produitfinancieresController.text,
          produitExceptionnels: produitExceptionnelsController.text,
          soldeDebiteur: soldeDebiteurController.text,
          signature: profilController.user.matricule,
          createdRef: data.createdRef,
          created: DateTime.now(),
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await compteResultatApi.updateData(compteResulatsModel).then((value) {
        compteResultatList.clear();
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

  void submitDD(CompteResulatsModel data) async {
    try {
      _isLoading.value = true;
      final compteResulatsModel = CompteResulatsModel(
          intitule: data.intitule,
          achatMarchandises: data.achatMarchandises,
          variationStockMarchandises: data.variationStockMarchandises,
          achatApprovionnements: data.achatApprovionnements,
          variationApprovionnements: data.variationApprovionnements,
          autresChargesExterne: data.autresChargesExterne,
          impotsTaxesVersementsAssimiles: data.impotsTaxesVersementsAssimiles,
          renumerationPersonnel: data.renumerationPersonnel,
          chargesSocialas: data.chargesSocialas,
          dotatiopnsProvisions: data.dotatiopnsProvisions,
          autresCharges: data.autresCharges,
          chargesfinancieres: data.chargesfinancieres,
          chargesExptionnelles: data.chargesExptionnelles,
          impotSurbenefices: data.impotSurbenefices,
          soldeCrediteur: data.soldeCrediteur,
          ventesMarchandises: data.ventesMarchandises,
          productionVendueBienEtSerices: data.productionVendueBienEtSerices,
          productionStockee: data.productionStockee,
          productionImmobilisee: data.productionImmobilisee,
          subventionExploitation: data.subventionExploitation,
          autreProduits: data.autreProduits,
          montantExportation: data.montantExportation,
          produitfinancieres: data.produitfinancieres,
          produitExceptionnels: data.produitExceptionnels,
          soldeDebiteur: data.soldeDebiteur,
          signature: data.signature,
          createdRef: data.createdRef,
          created: data.created,
          approbationDD: approbationDD,
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await compteResultatApi.updateData(compteResulatsModel).then((value) {
        compteResultatList.clear();
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
