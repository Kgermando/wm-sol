import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/mails/mail_api.dart';
import 'package:wm_solution/src/api/rh/paiement_salaire_api.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/mail/mail_model.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/utils/salaire_dropsown.dart';

class SalaireController extends GetxController
    with StateMixin<List<PaiementSalaireModel>> {
  final PaiementSalaireApi paiementSalaireApi = PaiementSalaireApi();
  final MailApi mailApi = MailApi();
  final ProfilController profilController = Get.find();
  final LignBudgetaireController lignBudgetaireController =
      Get.put(LignBudgetaireController());

  List<PaiementSalaireModel> paiementSalaireList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final List<String> tauxJourHeureMoisSalaireList =
      SalaireDropdown().tauxJourHeureMoisSalaireDropdown;

  final TextEditingController joursHeuresPayeA100PourecentSalaireController =
      TextEditingController();
  final TextEditingController totalDuSalaireController =
      TextEditingController();
  final TextEditingController nombreHeureSupplementairesController =
      TextEditingController();
  final TextEditingController tauxHeureSupplementairesController =
      TextEditingController();
  final TextEditingController totalDuHeureSupplementairesController =
      TextEditingController();
  final TextEditingController
      supplementTravailSamediDimancheJoursFerieController =
      TextEditingController();
  final TextEditingController primeController = TextEditingController();
  final TextEditingController diversController = TextEditingController();
  final TextEditingController joursCongesPayeController =
      TextEditingController();
  final TextEditingController tauxCongesPayeController =
      TextEditingController();
  final TextEditingController totalDuCongePayeController =
      TextEditingController();
  final TextEditingController jourPayeMaladieAccidentController =
      TextEditingController();
  final TextEditingController tauxJournalierMaladieAccidentController =
      TextEditingController();
  final TextEditingController totalDuMaladieAccidentController =
      TextEditingController();
  final TextEditingController pensionDeductionController =
      TextEditingController();
  final TextEditingController indemniteCompensatricesDeductionController =
      TextEditingController();
  final TextEditingController avancesDeductionController =
      TextEditingController();
  final TextEditingController diversDeductionController =
      TextEditingController();
  final TextEditingController retenuesFiscalesDeductionController =
      TextEditingController();
  final TextEditingController
      nombreEnfantBeneficaireAllocationsFamilialesController =
      TextEditingController();
  final TextEditingController nombreDeJoursAllocationsFamilialesController =
      TextEditingController();
  final TextEditingController tauxJoursAllocationsFamilialesController =
      TextEditingController();
  final TextEditingController totalAPayerAllocationsFamilialesController =
      TextEditingController();
  final TextEditingController netAPayerController = TextEditingController();
  final TextEditingController
      montantPrisConsiderationCalculCotisationsINSSController =
      TextEditingController();
  final TextEditingController totalDuBrutController = TextEditingController();

  String? tauxJourHeureMoisSalaire;

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
  String? budget;
  String? ligneBudgtaire;
  String? ressource;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    joursHeuresPayeA100PourecentSalaireController.dispose();
    totalDuSalaireController.dispose();
    nombreHeureSupplementairesController.dispose();
    tauxHeureSupplementairesController.dispose();
    totalDuHeureSupplementairesController.dispose();
    supplementTravailSamediDimancheJoursFerieController.dispose();
    primeController.dispose();
    diversController.dispose();
    joursCongesPayeController.dispose();
    tauxCongesPayeController.dispose();
    totalDuCongePayeController.dispose();
    jourPayeMaladieAccidentController.dispose();
    tauxJournalierMaladieAccidentController.dispose();
    totalDuMaladieAccidentController.dispose();
    pensionDeductionController.dispose();
    indemniteCompensatricesDeductionController.dispose();
    retenuesFiscalesDeductionController.dispose();
    nombreEnfantBeneficaireAllocationsFamilialesController.dispose();
    nombreDeJoursAllocationsFamilialesController.dispose();
    tauxJoursAllocationsFamilialesController.dispose();
    totalAPayerAllocationsFamilialesController.dispose();
    netAPayerController.dispose();
    montantPrisConsiderationCalculCotisationsINSSController.dispose();
    totalDuBrutController.dispose();
    super.dispose();
  }

  void clear() {
    budget = null;
    ligneBudgtaire = null;
    ressource = null;
    tauxJourHeureMoisSalaire = null;
    joursHeuresPayeA100PourecentSalaireController.clear();
    totalDuSalaireController.clear();
    nombreHeureSupplementairesController.clear();
    tauxHeureSupplementairesController.clear();
    totalDuHeureSupplementairesController.clear();
    supplementTravailSamediDimancheJoursFerieController.clear();
    primeController.clear();
    diversController.clear();
    joursCongesPayeController.clear();
    tauxCongesPayeController.clear();
    totalDuCongePayeController.clear();
    jourPayeMaladieAccidentController.clear();
    tauxJournalierMaladieAccidentController.clear();
    totalDuMaladieAccidentController.clear();
    pensionDeductionController.clear();
    indemniteCompensatricesDeductionController.clear();
    retenuesFiscalesDeductionController.clear();
    nombreEnfantBeneficaireAllocationsFamilialesController.clear();
    nombreDeJoursAllocationsFamilialesController.clear();
    tauxJoursAllocationsFamilialesController.clear();
    totalAPayerAllocationsFamilialesController.clear();
    netAPayerController.clear();
    montantPrisConsiderationCalculCotisationsINSSController.clear();
    totalDuBrutController.clear();
  }

  void getList() async {
    await paiementSalaireApi.getAllData().then((response) {
      paiementSalaireList.clear();
      paiementSalaireList.addAll(response);
      change(paiementSalaireList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await paiementSalaireApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await paiementSalaireApi.deleteData(id).then((value) {
        paiementSalaireList.clear();
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

  Future submit(AgentModel agentModel) async {
    final form = formKey.currentState!;
    if (form.validate()) {
      try {
        _isLoading.value = true;
        final paiementSalaireModel = PaiementSalaireModel(
            nom: agentModel.nom,
            postNom: agentModel.postNom,
            prenom: agentModel.prenom,
            email: agentModel.email,
            telephone: agentModel.telephone,
            adresse: agentModel.adresse,
            departement: agentModel.departement,
            numeroSecuriteSociale: agentModel.numeroSecuriteSociale,
            matricule: agentModel.matricule,
            servicesAffectation: agentModel.servicesAffectation,
            salaire: agentModel.salaire,
            observation: 'false', // Finance
            modePaiement: '-',
            createdAt: DateTime.now(),
            tauxJourHeureMoisSalaire:
                (tauxJourHeureMoisSalaire == '' || tauxJourHeureMoisSalaire == null)
                    ? '-'
                    : tauxJourHeureMoisSalaire.toString(),
            joursHeuresPayeA100PourecentSalaire:
                (joursHeuresPayeA100PourecentSalaireController.text == '')
                    ? '-'
                    : joursHeuresPayeA100PourecentSalaireController.text,
            totalDuSalaire: (totalDuSalaireController.text == '')
                ? '-'
                : totalDuSalaireController.text,
            nombreHeureSupplementaires: (nombreHeureSupplementairesController.text == '')
                ? '-'
                : nombreHeureSupplementairesController.text,
            tauxHeureSupplementaires: (tauxHeureSupplementairesController.text == '')
                ? '-'
                : tauxHeureSupplementairesController.text,
            totalDuHeureSupplementaires:
                (totalDuHeureSupplementairesController.text == '')
                    ? '-'
                    : totalDuHeureSupplementairesController.text,
            supplementTravailSamediDimancheJoursFerie:
                (supplementTravailSamediDimancheJoursFerieController.text == '')
                    ? '-'
                    : supplementTravailSamediDimancheJoursFerieController.text,
            prime: (primeController.text == '') ? '-' : primeController.text,
            divers: (diversController.text == '') ? '-' : diversController.text,
            joursCongesPaye: (joursCongesPayeController.text == '')
                ? '-'
                : joursCongesPayeController.text,
            tauxCongesPaye: (tauxCongesPayeController.text == '')
                ? '-'
                : tauxCongesPayeController.text,
            totalDuCongePaye: (totalDuCongePayeController.text == '') ? '-' : totalDuCongePayeController.text,
            jourPayeMaladieAccident: (jourPayeMaladieAccidentController.text == '') ? '-' : jourPayeMaladieAccidentController.text,
            tauxJournalierMaladieAccident: (tauxJournalierMaladieAccidentController.text == '') ? '-' : tauxJournalierMaladieAccidentController.text,
            totalDuMaladieAccident: (totalDuMaladieAccidentController.text == '') ? '-' : totalDuMaladieAccidentController.text,
            pensionDeduction: (pensionDeductionController.text == '') ? '-' : pensionDeductionController.text,
            indemniteCompensatricesDeduction: (indemniteCompensatricesDeductionController.text == '') ? '-' : indemniteCompensatricesDeductionController.text,
            avancesDeduction: (avancesDeductionController.text == '') ? '-' : avancesDeductionController.text,
            diversDeduction: (diversDeductionController.text == '') ? '-' : diversDeductionController.text,
            retenuesFiscalesDeduction: (retenuesFiscalesDeductionController.text == '') ? '-' : retenuesFiscalesDeductionController.text,
            nombreEnfantBeneficaireAllocationsFamiliales: (nombreEnfantBeneficaireAllocationsFamilialesController.text == '') ? '-' : retenuesFiscalesDeductionController.text,
            nombreDeJoursAllocationsFamiliales: (nombreDeJoursAllocationsFamilialesController.text == '') ? '-' : nombreDeJoursAllocationsFamilialesController.text,
            tauxJoursAllocationsFamiliales: (tauxJoursAllocationsFamilialesController.text == '') ? '-' : tauxJoursAllocationsFamilialesController.text,
            totalAPayerAllocationsFamiliales: (totalAPayerAllocationsFamilialesController.text == '') ? '-' : totalAPayerAllocationsFamilialesController.text,
            netAPayer: (netAPayerController.text == '') ? '-' : netAPayerController.text,
            montantPrisConsiderationCalculCotisationsINSS: (montantPrisConsiderationCalculCotisationsINSSController.text == '') ? '-' : montantPrisConsiderationCalculCotisationsINSSController.text,
            totalDuBrut: (totalDuBrutController.text == '') ? '-' : totalDuBrutController.text,
            signature: profilController.user.matricule,
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
        await paiementSalaireApi.insertData(paiementSalaireModel).then((value) {
          clear();
          paiementSalaireList.clear();
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

  void submitObservation(PaiementSalaireModel data) async {
    try {
      _isLoading.value = true;
      final paiementSalaireModel = PaiementSalaireModel(
          id: data.id,
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          email: data.email,
          telephone: data.telephone,
          adresse: data.adresse,
          departement: data.departement,
          numeroSecuriteSociale: data.numeroSecuriteSociale,
          matricule: data.matricule,
          servicesAffectation: data.servicesAffectation,
          salaire: data.salaire,
          observation: 'true',
          modePaiement: data.modePaiement,
          createdAt: data.createdAt,
          tauxJourHeureMoisSalaire: data.tauxJourHeureMoisSalaire,
          joursHeuresPayeA100PourecentSalaire:
              data.joursHeuresPayeA100PourecentSalaire,
          totalDuSalaire: data.totalDuSalaire,
          nombreHeureSupplementaires: data.nombreHeureSupplementaires,
          tauxHeureSupplementaires: data.tauxHeureSupplementaires,
          totalDuHeureSupplementaires: data.totalDuHeureSupplementaires,
          supplementTravailSamediDimancheJoursFerie:
              data.supplementTravailSamediDimancheJoursFerie,
          prime: data.prime,
          divers: data.divers,
          joursCongesPaye: data.joursCongesPaye,
          tauxCongesPaye: data.tauxCongesPaye,
          totalDuCongePaye: data.totalDuCongePaye,
          jourPayeMaladieAccident: data.jourPayeMaladieAccident,
          tauxJournalierMaladieAccident: data.tauxJournalierMaladieAccident,
          totalDuMaladieAccident: data.totalDuMaladieAccident,
          pensionDeduction: data.pensionDeduction,
          indemniteCompensatricesDeduction:
              data.indemniteCompensatricesDeduction,
          avancesDeduction: data.avancesDeduction,
          diversDeduction: data.diversDeduction,
          retenuesFiscalesDeduction: data.retenuesFiscalesDeduction,
          nombreEnfantBeneficaireAllocationsFamiliales:
              data.nombreEnfantBeneficaireAllocationsFamiliales,
          nombreDeJoursAllocationsFamiliales:
              data.nombreDeJoursAllocationsFamiliales,
          tauxJoursAllocationsFamiliales: data.tauxJoursAllocationsFamiliales,
          totalAPayerAllocationsFamiliales:
              data.totalAPayerAllocationsFamiliales,
          netAPayer: data.netAPayer,
          montantPrisConsiderationCalculCotisationsINSS:
              data.montantPrisConsiderationCalculCotisationsINSS,
          totalDuBrut: data.totalDuBrut,
          signature: data.signature,
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
      await paiementSalaireApi.updateData(paiementSalaireModel).then((value) {
        clear();
        paiementSalaireList.clear();
        getList();
        Get.back();
        Get.snackbar("Observation effectuée avec succès!",
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

  Future<void> submitDD(PaiementSalaireModel data) async {
    try {
      _isLoading.value = true;
      final paiementSalaireModel = PaiementSalaireModel(
          id: data.id,
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          email: data.email,
          telephone: data.telephone,
          adresse: data.adresse,
          departement: data.departement,
          numeroSecuriteSociale: data.numeroSecuriteSociale,
          matricule: data.matricule,
          servicesAffectation: data.servicesAffectation,
          salaire: data.salaire,
          observation: data.observation,
          modePaiement: data.modePaiement,
          createdAt: data.createdAt,
          tauxJourHeureMoisSalaire: data.tauxJourHeureMoisSalaire,
          joursHeuresPayeA100PourecentSalaire:
              data.joursHeuresPayeA100PourecentSalaire,
          totalDuSalaire: data.totalDuSalaire,
          nombreHeureSupplementaires: data.nombreHeureSupplementaires,
          tauxHeureSupplementaires: data.tauxHeureSupplementaires,
          totalDuHeureSupplementaires: data.totalDuHeureSupplementaires,
          supplementTravailSamediDimancheJoursFerie:
              data.supplementTravailSamediDimancheJoursFerie,
          prime: data.prime,
          divers: data.divers,
          joursCongesPaye: data.joursCongesPaye,
          tauxCongesPaye: data.tauxCongesPaye,
          totalDuCongePaye: data.totalDuCongePaye,
          jourPayeMaladieAccident: data.jourPayeMaladieAccident,
          tauxJournalierMaladieAccident: data.tauxJournalierMaladieAccident,
          totalDuMaladieAccident: data.totalDuMaladieAccident,
          pensionDeduction: data.pensionDeduction,
          indemniteCompensatricesDeduction:
              data.indemniteCompensatricesDeduction,
          avancesDeduction: data.avancesDeduction,
          diversDeduction: data.diversDeduction,
          retenuesFiscalesDeduction: data.retenuesFiscalesDeduction,
          nombreEnfantBeneficaireAllocationsFamiliales:
              data.nombreEnfantBeneficaireAllocationsFamiliales,
          nombreDeJoursAllocationsFamiliales:
              data.nombreDeJoursAllocationsFamiliales,
          tauxJoursAllocationsFamiliales: data.tauxJoursAllocationsFamiliales,
          totalAPayerAllocationsFamiliales:
              data.totalAPayerAllocationsFamiliales,
          netAPayer: data.netAPayer,
          montantPrisConsiderationCalculCotisationsINSS:
              data.montantPrisConsiderationCalculCotisationsINSS,
          totalDuBrut: data.totalDuBrut,
          signature: data.signature,
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
      await paiementSalaireApi.updateData(paiementSalaireModel).then((value) {
        clear();
        paiementSalaireList.clear();
        getList();
        Get.back();
        Get.snackbar(
            "Effectuée avec succès!", "Le document a bien été sauvegadé",
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

  Future<void> submitBudget(PaiementSalaireModel data) async {
    try {
      _isLoading.value = true;
      final paiementSalaireModel = PaiementSalaireModel(
          id: data.id,
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          email: data.email,
          telephone: data.telephone,
          adresse: data.adresse,
          departement: data.departement,
          numeroSecuriteSociale: data.numeroSecuriteSociale,
          matricule: data.matricule,
          servicesAffectation: data.servicesAffectation,
          salaire: data.salaire,
          observation: data.observation,
          modePaiement: data.modePaiement,
          createdAt: data.createdAt,
          tauxJourHeureMoisSalaire: data.tauxJourHeureMoisSalaire,
          joursHeuresPayeA100PourecentSalaire:
              data.joursHeuresPayeA100PourecentSalaire,
          totalDuSalaire: data.totalDuSalaire,
          nombreHeureSupplementaires: data.nombreHeureSupplementaires,
          tauxHeureSupplementaires: data.tauxHeureSupplementaires,
          totalDuHeureSupplementaires: data.totalDuHeureSupplementaires,
          supplementTravailSamediDimancheJoursFerie:
              data.supplementTravailSamediDimancheJoursFerie,
          prime: data.prime,
          divers: data.divers,
          joursCongesPaye: data.joursCongesPaye,
          tauxCongesPaye: data.tauxCongesPaye,
          totalDuCongePaye: data.totalDuCongePaye,
          jourPayeMaladieAccident: data.jourPayeMaladieAccident,
          tauxJournalierMaladieAccident: data.tauxJournalierMaladieAccident,
          totalDuMaladieAccident: data.totalDuMaladieAccident,
          pensionDeduction: data.pensionDeduction,
          indemniteCompensatricesDeduction:
              data.indemniteCompensatricesDeduction,
          avancesDeduction: data.avancesDeduction,
          diversDeduction: data.diversDeduction,
          retenuesFiscalesDeduction: data.retenuesFiscalesDeduction,
          nombreEnfantBeneficaireAllocationsFamiliales:
              data.nombreEnfantBeneficaireAllocationsFamiliales,
          nombreDeJoursAllocationsFamiliales:
              data.nombreDeJoursAllocationsFamiliales,
          tauxJoursAllocationsFamiliales: data.tauxJoursAllocationsFamiliales,
          totalAPayerAllocationsFamiliales:
              data.totalAPayerAllocationsFamiliales,
          netAPayer: data.netAPayer,
          montantPrisConsiderationCalculCotisationsINSS:
              data.montantPrisConsiderationCalculCotisationsINSS,
          totalDuBrut: data.totalDuBrut,
          signature: data.signature,
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
      await paiementSalaireApi
          .updateData(paiementSalaireModel)
          .then((value) async {
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
                ligneBudget.caisseSortie + double.parse(value.salaire),
            banqueSortie: ligneBudget.banqueSortie,
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            paiementSalaireList.clear();
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
                ligneBudget.banqueSortie + double.parse(value.salaire),
            finExterieurSortie: ligneBudget.finExterieurSortie,
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            paiementSalaireList.clear();
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
            finExterieurSortie:
                ligneBudget.finExterieurSortie + double.parse(value.salaire),
          );
          await lignBudgetaireController.lIgneBudgetaireApi
              .updateData(ligneBudgetaireModel)
              .then((value) {
            clear();
            paiementSalaireList.clear();
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
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> submitFin(PaiementSalaireModel data) async {
    try {
      _isLoading.value = true;
      final paiementSalaireModel = PaiementSalaireModel(
          id: data.id,
          nom: data.nom,
          postNom: data.postNom,
          prenom: data.prenom,
          email: data.email,
          telephone: data.telephone,
          adresse: data.adresse,
          departement: data.departement,
          numeroSecuriteSociale: data.numeroSecuriteSociale,
          matricule: data.matricule,
          servicesAffectation: data.servicesAffectation,
          salaire: data.salaire,
          observation: data.observation,
          modePaiement: data.modePaiement,
          createdAt: data.createdAt,
          tauxJourHeureMoisSalaire: data.tauxJourHeureMoisSalaire,
          joursHeuresPayeA100PourecentSalaire:
              data.joursHeuresPayeA100PourecentSalaire,
          totalDuSalaire: data.totalDuSalaire,
          nombreHeureSupplementaires: data.nombreHeureSupplementaires,
          tauxHeureSupplementaires: data.tauxHeureSupplementaires,
          totalDuHeureSupplementaires: data.totalDuHeureSupplementaires,
          supplementTravailSamediDimancheJoursFerie:
              data.supplementTravailSamediDimancheJoursFerie,
          prime: data.prime,
          divers: data.divers,
          joursCongesPaye: data.joursCongesPaye,
          tauxCongesPaye: data.tauxCongesPaye,
          totalDuCongePaye: data.totalDuCongePaye,
          jourPayeMaladieAccident: data.jourPayeMaladieAccident,
          tauxJournalierMaladieAccident: data.tauxJournalierMaladieAccident,
          totalDuMaladieAccident: data.totalDuMaladieAccident,
          pensionDeduction: data.pensionDeduction,
          indemniteCompensatricesDeduction:
              data.indemniteCompensatricesDeduction,
          avancesDeduction: data.avancesDeduction,
          diversDeduction: data.diversDeduction,
          retenuesFiscalesDeduction: data.retenuesFiscalesDeduction,
          nombreEnfantBeneficaireAllocationsFamiliales:
              data.nombreEnfantBeneficaireAllocationsFamiliales,
          nombreDeJoursAllocationsFamiliales:
              data.nombreDeJoursAllocationsFamiliales,
          tauxJoursAllocationsFamiliales: data.tauxJoursAllocationsFamiliales,
          totalAPayerAllocationsFamiliales:
              data.totalAPayerAllocationsFamiliales,
          netAPayer: data.netAPayer,
          montantPrisConsiderationCalculCotisationsINSS:
              data.montantPrisConsiderationCalculCotisationsINSS,
          totalDuBrut: data.totalDuBrut,
          signature: data.signature,
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
      await paiementSalaireApi.updateData(paiementSalaireModel).then((value) {
        clear();
        sendEmail(value).then((value) {
          Get.back();
          Get.snackbar(
              "Effectuée avec succès!", "Le document a bien été sauvegadé",
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

  //Senfd Email
  Future<void> sendEmail(PaiementSalaireModel data) async {
    String mois = '';
    if (DateTime.now().month == 1) {
      mois = 'Janvier';
    } else if (DateTime.now().month == 2) {
      mois = 'Février';
    } else if (DateTime.now().month == 3) {
      mois = 'Mars';
    } else if (DateTime.now().month == 4) {
      mois = 'Avril';
    } else if (DateTime.now().month == 5) {
      mois = 'Mai';
    } else if (DateTime.now().month == 6) {
      mois = 'Juin';
    } else if (DateTime.now().month == 7) {
      mois = 'Juillet';
    } else if (DateTime.now().month == 8) {
      mois = 'Août';
    } else if (DateTime.now().month == 9) {
      mois = 'Septembre';
    } else if (DateTime.now().month == 10) {
      mois = 'Octobre';
    } else if (DateTime.now().month == 11) {
      mois = 'Novembre';
    } else if (DateTime.now().month == 12) {
      mois = 'Décembre';
    }
    final mailModel = MailModel(
        fullName: "${data.prenom} ${data.nom}",
        email: data.email,
        cc: '-',
        objet: "SALAIRE",
        message:
            "Bonjour ${data.prenom}, votre salaire de $mois est maintenant disponible.",
        pieceJointe: "-",
        read: 'false',
        fullNameDest:
            "${profilController.user.prenom} ${profilController.user.nom}",
        emailDest: profilController.user.email,
        dateSend: DateTime.now(),
        dateRead: DateTime.now());
    await mailApi.insertData(mailModel);
  }
}
