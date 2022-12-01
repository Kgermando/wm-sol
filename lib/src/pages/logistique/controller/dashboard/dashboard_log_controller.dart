import 'package:get/get.dart';
import 'package:wm_solution/src/pages/logistique/controller/materiels/materiel_controller.dart';  
import 'package:wm_solution/src/pages/logistique/controller/trajets/trajet_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/etat_materiel/etat_materiel_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/immobiliers/immobilier_controller.dart';
import 'package:wm_solution/src/pages/logistique/controller/mobiliers/mobilier_controller.dart';

class DashboardLogController extends GetxController {
  final MaterielController materielController = Get.put(MaterielController());
  final TrajetController trajetController = Get.put(TrajetController());
  final EtatMaterielController etatMaterielController = Get.put(EtatMaterielController());
  final ImmobilierController immobilierController = Get.put(ImmobilierController());
  final MobilierController mobilierController = Get.put(MobilierController());
    
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
    var materiels = await materielController.materielsApi.getAllData();
    _materielCount.value = materiels
        .where((element) => element.typeMateriel == 'Materiel' &&
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    _materielCountRoulant.value = materiels
        .where((element) => element.typeMateriel == 'Materiel roulant' &&
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    var mobiliers = await mobilierController.mobilierApi.getAllData();
    _mobilierCount.value = mobiliers
        .where((element) => element.approbationDD == "Approved")
        .length;
    var immobiliers = await immobilierController.immobilierApi.getAllData();
    _immobilierCount.value = immobiliers
        .where((element) =>
            element.approbationDG == "Approved" &&
            element.approbationDD == "Approved")
        .length;
    var etatMateriels = await etatMaterielController.etatMaterielApi.getAllData();
    _etatMaterielActif.value = etatMateriels
        .where((element) =>
            element.statut == "Actif" && element.approbationDD == "Approved")
        .length;
    _etatMaterielInActif.value = etatMateriels
        .where((element) =>
            element.statut == "Inactif" && element.approbationDD == "Approved")
        .length;
    _etatMaterielDeclaser.value = etatMateriels
        .where((element) =>
            element.statut == "Declaser" && element.approbationDD == "Approved")
        .length;

     update();
  }
}
