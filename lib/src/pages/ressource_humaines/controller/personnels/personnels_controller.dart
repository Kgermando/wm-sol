import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:wm_solution/src/api/rh/performence_api.dart';
import 'package:wm_solution/src/api/rh/personnels_api.dart';
import 'package:wm_solution/src/api/upload_file_api.dart';
import 'package:wm_solution/src/models/rh/agent_count_model.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/country.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/fonction_occupe.dart';
import 'package:wm_solution/src/utils/service_affectation.dart';
 
class PersonnelsController extends GetxController
    with StateMixin<List<AgentModel>> {
  PersonnelsApi personnelsApi = PersonnelsApi();
  PerformenceApi performenceApi = PerformenceApi();
  final ProfilController profilController = Get.find();

  List<AgentModel> personnelsList = [];
  var agentPieChartList = <AgentPieChartModel>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<String> departementList = Dropdown().departement;
  List<String> typeContratList = Dropdown().typeContrat;
  List<String> sexeList = Dropdown().sexe;
  List<String> world = Country().world;

  // Fontion occupée
  List<String> fonctionActionnaireList = FonctionOccupee().actionnaireDropdown;
  List<String> fonctionAdminList = FonctionOccupee().adminDropdown;
  List<String> fonctionrhList = FonctionOccupee().rhDropdown;
  List<String> fonctionFinList = FonctionOccupee().finDropdown;
  List<String> fonctionBudList = FonctionOccupee().budDropdown;
  List<String> fonctionComptabiliteList =
      FonctionOccupee().comptabiliteDropdown;
  List<String> fonctionMarketingList = FonctionOccupee().marketingDropdown;
  List<String> fonctionExpList = FonctionOccupee().expDropdown;
  List<String> fonctionCommList = FonctionOccupee().commDropdown;
  List<String> fonctionlogList = FonctionOccupee().logDropdown;

  // Service d'affectation
  // List<String> serviceAffectation =ServiceAffectation().serviceAffectationDropdown;
  List<String> serviceAffectationActionnaire =
      ServiceAffectation().actionnaireDropdown;
  List<String> serviceAffectationAdmin = ServiceAffectation().adminDropdown;
  List<String> serviceAffectationRH = ServiceAffectation().rhDropdown;
  List<String> serviceAffectationFin = ServiceAffectation().finDropdown;
  List<String> serviceAffectationBud = ServiceAffectation().budgetDropdown;
  List<String> serviceAffectationCompt = ServiceAffectation().comptableDropdown;
  List<String> serviceAffectationEXp = ServiceAffectation().expDropdown;
  List<String> serviceAffectationCom = ServiceAffectation().comDropdown;
  List<String> serviceAffectationMark = ServiceAffectation().markDropdown;
  List<String> serviceAffectationLog = ServiceAffectation().logDropdown;

  TextEditingController nomController = TextEditingController();
  TextEditingController postNomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController numeroSecuriteSocialeController =
      TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController lieuNaissanceController = TextEditingController();
  TextEditingController dateDebutContratController = TextEditingController();
  TextEditingController dateFinContratController = TextEditingController();
  TextEditingController salaireController = TextEditingController();

  flutter_quill.QuillController competanceController = flutter_quill.QuillController.basic();
  // flutter_quill.QuillController experienceController = flutter_quill.QuillController.basic();


  int identifiant = 1;
  String matricule = "";
  String? sexe;
  String? role;
  String? nationalite;
  List<String> departementSelectedList = [];
  List<String> departementSelectedUpdateList = [];
  // String? departement;
  String? typeContrat;
  String? servicesAffectation;
  String? fonctionOccupe;

  List<String> servAffectList = [];
  List<String> fonctionList = [];  

  final _isUploading = false.obs;
  bool get isUploading => _isUploading.value;
  final _isUploadingDone = false.obs;
  bool get isUploadingDone => _isUploadingDone.value;

  final _uploadedFileUrl = ''.obs;
  String get uploadedFileUrl => _uploadedFileUrl.value;

  void uploadFile(String file) async {
    _isUploading.value = true;
    await FileApi().uploadFiled(file).then((value) {
      _uploadedFileUrl.value = value;
      _isUploading.value = false;
      _isUploadingDone.value = true;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getList();
    agentPieChart();
  }

  @override
  void dispose() {
    nomController.dispose();
    postNomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    numeroSecuriteSocialeController.dispose();
    dateNaissanceController.dispose();
    lieuNaissanceController.dispose();
    dateDebutContratController.dispose();
    dateFinContratController.dispose();
    competanceController.dispose();
    // experienceController.dispose();
    salaireController.dispose();

    super.dispose();
  }

  void clear() {
    departementSelectedList = [];
    nomController.clear();
    postNomController.clear();
    prenomController.clear();
    emailController.clear();
    telephoneController.clear();
    adresseController.clear();
    numeroSecuriteSocialeController.clear();
    dateNaissanceController.clear();
    lieuNaissanceController.clear();
    dateDebutContratController.clear();
    dateFinContratController.clear();
    competanceController.clear();
    // experienceController.clear();
    salaireController.clear();
  }

  void getList() async {
    personnelsApi.getAllData().then((response) {
      personnelsList.clear();
      identifiant = response.length + 1;
      personnelsList.addAll(response);
      change(personnelsList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void agentPieChart() async {
    personnelsApi.getChartPieSexe().then((response) {
      agentPieChartList.clear();
      agentPieChartList.addAll(response);
      change(personnelsList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) => personnelsApi.getOneData(id);


  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await personnelsApi.deleteData(id).then((value) {
        clear();
        personnelsList.clear();
        getList();
        // Get.back();
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


  Future submit() async {  
    try { 
      _isLoading.value = true;
      var departement = jsonEncode(departementSelectedList);
      var competanceJson =
        jsonEncode(competanceController.document.toDelta().toJson());
      final agentModel = AgentModel(
          nom: (nomController.text == '') ? '-' : nomController.text,
          postNom:
              (postNomController.text == '') ? '-' : postNomController.text,
          prenom: (prenomController.text == '') ? '-' : prenomController.text,
          email: (emailController.text == '') ? '-' : emailController.text,
          telephone:
              (telephoneController.text == '') ? '-' : telephoneController.text,
          adresse:
              (adresseController.text == '') ? '-' : adresseController.text,
          sexe: (sexe.toString() == '') ? '-' : sexe.toString(),
          role: (role.toString() == '') ? '-' : role.toString(),
          matricule: (matricule == '') ? '-' : matricule,
          numeroSecuriteSociale: (numeroSecuriteSocialeController.text == "")
              ? "-"
              : numeroSecuriteSocialeController.text,
          dateNaissance: (dateNaissanceController.text == '')
              ? DateTime.now()
              : DateTime.parse(dateNaissanceController.text),
          lieuNaissance: (lieuNaissanceController.text == '')
              ? '-'
              : lieuNaissanceController.text,
          nationalite:
              (nationalite.toString() == '') ? '-' : nationalite.toString(),
          typeContrat:
              (typeContrat.toString() == '') ? '-' : typeContrat.toString(),
          departement: departement,
          servicesAffectation: (servicesAffectation.toString() == '')
              ? '-'
              : servicesAffectation.toString(),
          dateDebutContrat: (dateDebutContratController.text == '')
              ? DateTime.now()
              : DateTime.parse(dateDebutContratController.text),
          dateFinContrat: DateTime.parse((dateFinContratController.text == "")
              ? "2099-12-31 00:00:00"
              : dateFinContratController.text),
          fonctionOccupe: (fonctionOccupe.toString() == '')
              ? '-'
              : fonctionOccupe.toString(),
          competance: competanceJson,
          experience: '-',
          statutAgent: 'Inactif',
          createdAt: DateTime.now(),
          photo: (uploadedFileUrl == '') ? 'https://www.jea.com/cdn/images/avatar.png' : uploadedFileUrl.toString(),
          salaire:
              (salaireController.text == '') ? '-' : salaireController.text,
          signature: profilController.user.matricule,
          created: DateTime.now());
      await personnelsApi.insertData(agentModel).then((value) async {
        final performenceModel = PerformenceModel(
          agent: value.matricule,
          departement: value.departement,
          nom: value.nom,
          postnom: value.postNom,
          prenom: value.prenom,
          signature: profilController.user.matricule,
          created: DateTime.now());
        await performenceApi.insertData(performenceModel).then((value) {
          clear();
          personnelsList.clear();
          getList();
          Get.back();
          Get.snackbar(
            "Enregistrement effectué!", "Le document a bien été créé!",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP);
        }); 
      });
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar(
        "Erreur s'est produite",
        "$e",
        backgroundColor: Colors.red,
      );
    }
  }

  
  Future submitUpdate(AgentModel personne) async {
    try {
      _isLoading.value = true;
        var departement = jsonEncode(departementSelectedUpdateList.toSet().toList());
      var competanceJson =
          jsonEncode(competanceController.document.toDelta().toJson());
  
      final agentModel = AgentModel(
          id: personne.id,
          nom: (nomController.text == '') ? personne.nom : nomController.text,
          postNom: (postNomController.text == '')
              ? personne.postNom
              : postNomController.text,
          prenom: (prenomController.text == '')
              ? personne.prenom
              : prenomController.text,
          email: (emailController.text == '')
              ? personne.email
              : emailController.text,
          telephone: (telephoneController.text == '')
              ? personne.telephone
              : telephoneController.text,
          adresse: (adresseController.text == '')
              ? personne.adresse
              : adresseController.text,
          sexe: (sexe.toString() == '') ? personne.sexe : sexe.toString(),
          role: (role.toString() == '') ? personne.role : role.toString(),
          matricule: personne.matricule,
          numeroSecuriteSociale: (numeroSecuriteSocialeController.text == "")
              ? personne.numeroSecuriteSociale
              : numeroSecuriteSocialeController.text,
          dateNaissance: (dateNaissanceController.text == '')
              ? personne.dateNaissance
              : DateTime.parse(dateNaissanceController.text),
          lieuNaissance: (lieuNaissanceController.text == '')
              ? personne.lieuNaissance
              : lieuNaissanceController.text,
          nationalite: (nationalite.toString() == '')
              ? personne.nationalite
              : nationalite.toString(),
          typeContrat: (typeContrat.toString() == '')
              ? personne.typeContrat
              : typeContrat.toString(),
          departement: (departement.toString() == '')
              ? personne.departement
              : departement.toString(),
          servicesAffectation: (servicesAffectation.toString() == '')
              ? personne.servicesAffectation
              : servicesAffectation.toString(),
          dateDebutContrat: (dateDebutContratController.text == '')
              ? personne.dateDebutContrat
              : DateTime.parse(dateDebutContratController.text),
          dateFinContrat: (dateFinContratController.text == '')
              ? personne.dateFinContrat
              : DateTime.parse(dateFinContratController.text),
          fonctionOccupe: (fonctionOccupe.toString() == '')
              ? personne.fonctionOccupe
              : fonctionOccupe.toString(),
          competance: competanceJson,
          experience: personne.experience,
          statutAgent: "Inactif", // Modification du profil est automatiquement Inactif
          createdAt: personne.createdAt,
          photo: (uploadedFileUrl == '')
              ? personne.photo
              : uploadedFileUrl.toString(),
          salaire: (salaireController.text == '')
              ? personne.salaire
              : salaireController.text,
          signature: profilController.user.matricule.toString(),
          created: DateTime.now());
      await personnelsApi.updateData(agentModel).then((value) {
        clear();
        personnelsList.clear();
        getList();
        Get.back();
        Get.snackbar("Modification effectué!", "Le document a bien été sauvegadé",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP); 
      });
       _isLoading.value = false;   
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    }
    
  }

  void updateStatus(AgentModel personne, String statutPersonel) async {
    try {
      _isLoading.value = true;
        final agentModel = AgentModel(
          id: personne.id,
          nom: personne.nom,
          postNom: personne.postNom,
          prenom: personne.prenom,
          email: personne.email,
          telephone: personne.telephone,
          adresse: personne.adresse,
          sexe: personne.sexe,
          role: personne.role,
          matricule: personne.matricule,
          numeroSecuriteSociale: personne.numeroSecuriteSociale,
          dateNaissance: personne.dateNaissance,
          lieuNaissance: personne.lieuNaissance,
          nationalite: personne.nationalite,
          typeContrat: personne.typeContrat,
          departement: personne.departement,
          servicesAffectation: personne.servicesAffectation,
          dateDebutContrat: personne.dateDebutContrat,
          dateFinContrat: personne.dateFinContrat,
          fonctionOccupe: personne.fonctionOccupe,
          competance: personne.competance,
          experience: personne.experience,
          statutAgent: statutPersonel,
          createdAt: personne.createdAt,
          photo: personne.photo,
          salaire: personne.salaire,
          signature: personne.signature,
          created: personne.created);
      await personnelsApi.updateData(agentModel).then((value) {
        clear(); 
        Get.back();
        Get.snackbar("Modification du statut effectué!",
            "Le document a bien été mise à jour.",
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check),
            snackPosition: SnackPosition.TOP); 
      });
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      Get.snackbar("Erreur de soumission", "$e",
          backgroundColor: Colors.red,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
      
    }
    
  }
}
