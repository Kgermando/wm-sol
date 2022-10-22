 import 'package:get/get.dart';
import 'package:wm_solution/src/models/logistiques/carburant_model.dart'; 
import 'package:wm_solution/src/pages/logistique/controller/automobiles/carburant_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/engin_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/automobiles/trajet_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class DashboardLogController extends GetxController {
  final EnginController enginController = Get.put(EnginController());
  final TrajetController trajetController = Get.put(TrajetController());
  final CarburantController carburantController = Get.put(CarburantController());
  final EtatMaterielController etatMaterielController = Get.put(EtatMaterielController());
  final ImmobilierController immobilierController = Get.put(ImmobilierController());
  final MobilierController mobilierController = Get.put(MobilierController());
    
  final _anguinsCount = 0.obs;
  int get anguinsCount => _anguinsCount.value;
    
  final _mobilierCount = 0.obs;
  int get mobilierCount => _mobilierCount.value;
    
  final _immobilierCount = 0.obs;
  int get immobilierCount => _immobilierCount.value;
    
  final _etatMaterielActif = 0.obs;
  int get etatMaterielActif => _etatMaterielActif.value;
 
  final _etatMaterielInActif = 0.obs;
  int get etatMaterielInActif => _etatMaterielInActif.value;
 
  final _etatMaterielDeclaser = 0.obs;
  int get etatMaterielDeclaser => _etatMaterielDeclaser.value;

 
  final _entrerEssence = 0.0.obs;
  double get entrerEssence => _entrerEssence.value;

    final _sortieEssence = 0.0.obs;
  double get sortieEssence => _sortieEssence.value;

    final _entrerMazoute = 0.0.obs;
  double get entrerMazoute => _entrerMazoute.value;

    final _sortieMazoute = 0.0.obs;
  double get sortieMazoute => _sortieMazoute.value;

    final _entrerHuilleMoteur = 0.0.obs;
  double get entrerHuilleMoteur => _entrerHuilleMoteur.value;

    final _sortieHuilleMoteur = 0.0.obs;
  double get sortieHuilleMoteur => _sortieHuilleMoteur.value;

  final _entrerPetrole = 0.0.obs;
  double get entrerPetrole => _entrerPetrole.value;

  final _sortiePetrole = 0.0.obs;
  double get sortiePetrole => _sortiePetrole.value;
   
  @override
  void onInit() {
    super.onInit();
    getData();
  }

 Future<void> getData() async {

    _anguinsCount.value = enginController.enginList
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    _mobilierCount.value = mobilierController.mobilierList
        .where((element) => element.approbationDD == "Approved")
        .length;
    _immobilierCount.value = immobilierController.immobilierList
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    var carburantsList = carburantController.carburantList
        .where((element) => element.approbationDD == "Approved")
        .toList();
    _etatMaterielActif.value = etatMaterielController.etatMaterielList
        .where((element) =>
            element.statut == "Actif" && element.approbationDD == "Approved")
        .length;
    _etatMaterielInActif.value = etatMaterielController.etatMaterielList
        .where((element) =>
            element.statut == "Inactif" && element.approbationDD == "Approved")
        .length;
    _etatMaterielDeclaser.value = etatMaterielController.etatMaterielList
        .where((element) =>
            element.statut == "Declaser" && element.approbationDD == "Approved")
        .length;

    List<CarburantModel?> entreListEssence = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Entrer" &&
            element.typeCaburant == "Essence")
        .toList();
    List<CarburantModel?> sortieListEssence = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Sortie" &&
            element.typeCaburant == "Essence")
        .toList();
    for (var item in entreListEssence) {
      _entrerEssence.value += double.parse(item!.qtyAchat);
    }
    for (var item in sortieListEssence) {
      _sortieEssence.value += double.parse(item!.qtyAchat);
    }

    List<CarburantModel> entrerListMazoute = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Entrer" &&
            element.typeCaburant == "Mazoutte")
        .toList();
    List<CarburantModel?> sortieListMazoute = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Sortie" &&
            element.typeCaburant == "Mazoutte")
        .toList();
    for (var item in entrerListMazoute) {
      _entrerMazoute.value += double.parse(item.qtyAchat);
    }
    for (var item in sortieListMazoute) {
      _sortieMazoute.value += double.parse(item!.qtyAchat);
    }

    List<CarburantModel?> entrerListHuilleMoteur = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Entrer" &&
            element.typeCaburant == "Huille moteur")
        .toList();
    List<CarburantModel?> sortieListHuilleMoteur = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Sortie" &&
            element.typeCaburant == "Huille moteur")
        .toList();
    for (var item in entrerListHuilleMoteur) {
      _entrerHuilleMoteur.value += double.parse(item!.qtyAchat);
    }
    for (var item in sortieListHuilleMoteur) {
      _sortieHuilleMoteur.value += double.parse(item!.qtyAchat);
    }

    List<CarburantModel> entrerListPetrole = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Entrer" &&
            element.typeCaburant == "Pétrole")
        .toList();
    List<CarburantModel> sortieListPetrole = carburantsList
        .where((element) =>
            element.operationEntreSortie == "Sortie" &&
            element.typeCaburant == "Pétrole")
        .toList();
    for (var item in entrerListPetrole) {
      _entrerPetrole.value += double.parse(item.qtyAchat);
    }
    for (var item in sortieListPetrole) {
      _sortiePetrole.value += double.parse(item.qtyAchat);
    }
  }
}
