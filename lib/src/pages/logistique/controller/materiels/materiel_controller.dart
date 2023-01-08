import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/api/logistiques/materiels_api.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';

class MaterielController extends GetxController
    with StateMixin<List<MaterielModel>> {
  final MaterielsApi materielsApi = MaterielsApi();
  final ProfilController profilController = Get.find();

  List<MaterielModel> materielList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  int identifiant = 1;

  // final genreDrop = EnguinsDropdown().enginDropdown;

  // Approbations
  String? approbationDG;
  String? approbationDD;
  TextEditingController motifDGController = TextEditingController();
  TextEditingController motifDDController = TextEditingController();

  String? typeMateriel;
  TextEditingController marqueController = TextEditingController();
  TextEditingController modeleController = TextEditingController();
  TextEditingController numeroRefController = TextEditingController();
  TextEditingController couleurController = TextEditingController();
  String? genreController;
  TextEditingController qtyMaxReservoirController = TextEditingController();
  TextEditingController dateFabricationController = TextEditingController();
  TextEditingController numeroPLaqueController = TextEditingController();
  TextEditingController kilometrageInitialeController = TextEditingController();
  TextEditingController fournisseurController = TextEditingController();
  String? alimentation;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  @override
  void dispose() {
    motifDGController.dispose();
    motifDDController.dispose();
    modeleController.dispose();
    marqueController.dispose();
    numeroRefController.dispose();
    couleurController.dispose(); 
    qtyMaxReservoirController.dispose();
    dateFabricationController.dispose();
    numeroPLaqueController.dispose();
    kilometrageInitialeController.dispose();
    fournisseurController.dispose();

    super.dispose();
  }

  void clear() {
    approbationDG == '-';
    approbationDD == '-';
    motifDGController.clear();
    motifDDController.clear();
    modeleController.clear();
    marqueController.clear();
    numeroRefController.clear();
    couleurController.clear();
    genreController == null;
    qtyMaxReservoirController.clear();
    dateFabricationController.clear();
    numeroPLaqueController.clear();
    kilometrageInitialeController.clear();
    fournisseurController.clear();
  }

  void getList() async {
    await materielsApi.getAllData().then((response) {
      materielList.clear();
      materielList.addAll(response);
      identifiant = materielList.length + 1;
      change(materielList, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  detailView(int id) async {
    final data = await materielsApi.getOneData(id);
    return data;
  }

  void deleteData(int id) async {
    try {
      _isLoading.value = true;
      await materielsApi.deleteData(id).then((value) {
        materielList.clear();
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
      String numero = '';
      if (identifiant < 10) {
        numero = "00$identifiant";
      } else if (identifiant < 99) {
        numero = "0$identifiant";
      } else {
        numero = "$identifiant";
      }
      final dataItem = MaterielModel(
          typeMateriel: typeMateriel.toString(),
          marque: marqueController.text,
          modele: modeleController.text,
          numeroRef: numeroRefController.text,
          couleur: couleurController.text,
          genre: (genreController.toString() == '') ? 'Autres' : genreController.toString(),
          qtyMaxReservoir: (qtyMaxReservoirController.text == '')
              ? '0'
              : qtyMaxReservoirController.text,
          dateFabrication: DateTime.parse(dateFabricationController.text),
          numeroPLaque: (numeroPLaqueController.text == '')
              ? '-'
              : numeroPLaqueController.text,
          identifiant: numero,
          kilometrageInitiale: (kilometrageInitialeController.text == '')
              ? '0'
              : kilometrageInitialeController.text,
          fournisseur: fournisseurController.text,
          alimentation: alimentation.toString(),
          signature: profilController.user.matricule,
          created: DateTime.now(),
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await materielsApi.insertData(dataItem).then((value) {
        clear();
        materielList.clear();
        getList();
        if (value.typeMateriel == 'Materiel roulant') {
          Get.toNamed(LogistiqueRoutes.logMaterielRoulant);
        }
        if (value.typeMateriel == 'Materiel') {
          Get.toNamed(LogistiqueRoutes.logMateriel);
        }
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
          icon: const Icon(Icons.close),
          snackPosition: SnackPosition.TOP);
    }
  }

  void submitUpdate(MaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MaterielModel(
          id: data.id!,
          typeMateriel: typeMateriel.toString(),
          modele: modeleController.text,
          marque: marqueController.text,
          numeroRef: numeroRefController.text,
          couleur: couleurController.text,
          genre: (genreController.toString() == '')
              ? data.genre
              : genreController.toString(),
          qtyMaxReservoir: (qtyMaxReservoirController.text == '')
              ? data.qtyMaxReservoir
              : qtyMaxReservoirController.text,
          dateFabrication: DateTime.parse(dateFabricationController.text),
          numeroPLaque: numeroPLaqueController.text,
          identifiant: data.identifiant,
          kilometrageInitiale: (kilometrageInitialeController.text == '')
              ? data.kilometrageInitiale
              : kilometrageInitialeController.text,
          fournisseur: fournisseurController.text,
          alimentation: (alimentation.toString() == '')
              ? data.alimentation
              : alimentation.toString(),
          signature: profilController.user.matricule,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: '-',
          motifDD: '-',
          signatureDD: '-');
      await materielsApi.updateData(dataItem).then((value) {
        clear();
        materielList.clear();
        getList();
        if (value.typeMateriel == 'Materiel roulant') {
          Get.toNamed(LogistiqueRoutes.logMaterielRoulant); 
        }
        if (value.typeMateriel == 'Materiel') {
          Get.toNamed(LogistiqueRoutes.logMateriel); 
        }
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

  void submitDG(MaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MaterielModel(
          id: data.id!,
          typeMateriel: data.typeMateriel,
          modele: data.modele,
          marque: data.marque,
          numeroRef: data.numeroRef,
          couleur: data.couleur,
          genre: data.genre,
          qtyMaxReservoir: data.qtyMaxReservoir,
          dateFabrication: data.dateFabrication,
          numeroPLaque: data.numeroPLaque,
          identifiant: data.identifiant,
          kilometrageInitiale: data.kilometrageInitiale,
          fournisseur: data.fournisseur,
          alimentation: data.alimentation,
          signature: data.signature,
          created: data.created,
          approbationDG: approbationDG.toString(),
          motifDG:
              (motifDGController.text == '') ? '-' : motifDGController.text,
          signatureDG: profilController.user.matricule,
          approbationDD: data.approbationDD,
          motifDD: data.motifDD,
          signatureDD: data.signatureDD);
      await materielsApi.updateData(dataItem).then((value) {
        clear();
        materielList.clear();
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

  void submitDD(MaterielModel data) async {
    try {
      _isLoading.value = true;
      final dataItem = MaterielModel(
          id: data.id!,
          typeMateriel: data.typeMateriel,
          modele: data.modele,
          marque: data.marque,
          numeroRef: data.numeroRef,
          couleur: data.couleur,
          genre: data.genre,
          qtyMaxReservoir: data.qtyMaxReservoir,
          dateFabrication: data.dateFabrication,
          numeroPLaque: data.numeroPLaque,
          identifiant: data.identifiant,
          kilometrageInitiale: data.kilometrageInitiale,
          fournisseur: data.fournisseur,
          alimentation: data.alimentation,
          signature: data.signature,
          created: data.created,
          approbationDG: '-',
          motifDG: '-',
          signatureDG: '-',
          approbationDD: approbationDD.toString(),
          motifDD:
              (motifDDController.text == '') ? '-' : motifDDController.text,
          signatureDD: profilController.user.matricule);
      await materielsApi.updateData(dataItem).then((value) {
        clear();
        materielList.clear();
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
}
