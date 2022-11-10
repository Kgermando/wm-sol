import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';  
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class DashboardLogController extends GetxController {
  final MaterielController materielController = Get.find();
  final TrajetController trajetController = Get.find();
  final EtatMaterielController etatMaterielController = Get.find();
  final ImmobilierController immobilierController = Get.find();
  final MobilierController mobilierController = Get.find();
    
  final _materielCount = 0.obs;
  int get materielCount => _materielCount.value;
  final _materielCountRoulant = 0.obs;
  int get materielCountRoulant => _materielCountRoulant.value;
    
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

    _materielCount.value = materielController.materielList
        .where((element) => element.typeMateriel == 'Materiel' &&
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    _materielCountRoulant.value = materielController.materielList
        .where((element) => element.typeMateriel == 'Materiel roulant' &&
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

     update();
  }
}
