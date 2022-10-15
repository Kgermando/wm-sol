import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/rh/performence_api.dart';
import 'package:wm_solution/src/api/rh/personnels_api.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/utils/country.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/fonction_occupe.dart';
import 'package:wm_solution/src/utils/service_affectation.dart';
import 'package:dospace/dospace.dart' as dospace;
import 'package:wm_solution/src/widgets/file_uploader.dart';

class PersonnelsController extends GetxController
    with StateMixin<List<AgentModel>> {
  PersonnelsApi personnelsApi = PersonnelsApi();
  PerformenceApi performenceApi = PerformenceApi();
  final ProfilController profilController = Get.put(ProfilController());

  var personnelsList = <AgentModel>[].obs;

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
  List<String> fonctionfinList = FonctionOccupee().finDropdown;
  List<String> fonctionbudList = FonctionOccupee().budDropdown;
  List<String> fonctioncompteList = FonctionOccupee().compteDropdown;
  List<String> fonctionexpList = FonctionOccupee().expDropdown;
  List<String> fonctioncommList = FonctionOccupee().commDropdown;
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
  List<String> serviceAffectationComm = ServiceAffectation().commDropdown;
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
  TextEditingController competanceController = TextEditingController();

  TextEditingController experienceController = TextEditingController();
  TextEditingController salaireController = TextEditingController();

  String matricule = "";
  String? sexe;
  String? role;
  String? nationalite;
  List<String> departementSelectedList = [];
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

  String? uploadedFileUrl;

  void photeUpload(File file) async {
    String projectName = "fokad-spaces";
    String region = "sfo3";
    String folderName = "profile";
    String? photoFileName;

    String extension = 'png';
    photoFileName = "${DateTime.now().millisecondsSinceEpoch}.$extension";

    uploadedFileUrl =
        "https://$projectName.$region.digitaloceanspaces.com/$folderName/$photoFileName";

    _isUploading.value = true;
    dospace.Bucket bucketphoto = FileUploader().spaces.bucket('fokad-spaces');
    String? profile = await bucketphoto.uploadFile('$folderName/$photoFileName',
        file, 'image/png', dospace.Permissions.public);
    _isUploading.value = false;
    _isUploadingDone.value = true;

    if (kDebugMode) {
      print('upload: $profile');
      print('done');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getList();
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
    experienceController.dispose();
    salaireController.dispose();

    super.dispose();
  }

  void getList() async {
    personnelsApi.getAllData().then((response) {
      personnelsList.assignAll(response);
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await personnelsApi.getOneData(id);
    return data;
  }

  Future submit() async {
    var departement = jsonEncode(departementSelectedList);
    final form = formKey.currentState!;
    if (form.validate()) {
      try {
        _isLoading.value = true;
        final agentModel = AgentModel(
            nom: (nomController.text == '') ? '-' : nomController.text,
            postNom:
                (postNomController.text == '') ? '-' : postNomController.text,
            prenom: (prenomController.text == '') ? '-' : prenomController.text,
            email: (emailController.text == '') ? '-' : emailController.text,
            telephone: (telephoneController.text == '')
                ? '-'
                : telephoneController.text,
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
            competance: (competanceController.text == '')
                ? '-'
                : competanceController.text,
            experience: (experienceController.text == '')
                ? '-'
                : experienceController.text,
            statutAgent: 'false',
            createdAt: DateTime.now(),
            photo: (uploadedFileUrl == '') ? '-' : uploadedFileUrl.toString(),
            salaire:
                (salaireController.text == '') ? '-' : salaireController.text,
            signature: profilController.user.matricule,
            created: DateTime.now());
        await personnelsApi.insertData(agentModel).then((value) async {
          await submitPerformence();
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
  }

  Future submitPerformence() async {
    var departement = jsonEncode(departementSelectedList);
    final performenceModel = PerformenceModel(
        agent: matricule,
        departement: departement,
        nom: nomController.text,
        postnom: postNomController.text,
        prenom: prenomController.text,
        signature: profilController.user.matricule,
        created: DateTime.now());
    await performenceApi.insertData(performenceModel).then((value) {
      personnelsList.clear();
      getList();
      Get.back();
      Get.snackbar(
          "Enregistrement effectué!", "Le document a bien été sauvegader",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    });
  }

  Future submitUpdate(AgentModel personne) async {
    var departement = jsonEncode(departementSelectedList);
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
        competance: (competanceController.text == '')
            ? personne.competance
            : competanceController.text,
        experience: (experienceController.text == '')
            ? personne.experience
            : experienceController.text,
        statutAgent: personne.statutAgent,
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
      personnelsList.clear();
      getList();
      Get.back();
      Get.snackbar(
          "Modification effectué!", "Le document a bien été sauvegader",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    });
  }

  void updateStatus(AgentModel personne, String statutPersonel) async {
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
      // detailView(value.id!);
      // Get.back();
      Get.snackbar("Modification du statut effectué!",
          "Le document a bien été mise à jour.",
          backgroundColor: Colors.green,
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP);
    });
  }
}
