import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/departements/logistique_departement.dart';
import 'package:wm_solution/src/api/notifications/logistique/materiel_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/entretien_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/etat_materiel_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/immobilier_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/mobilier_notify_api.dart';
import 'package:wm_solution/src/api/notifications/logistique/trajet_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class NotifyLogController extends GetxController {
  final MaterielNotifyApi materielNotifyApi = MaterielNotifyApi();
  final TrajetNotifyApi trajetNotifyApi = TrajetNotifyApi();
  final ImmobilierNotifyApi immobilierNotifyApi = ImmobilierNotifyApi();
  final MobilierNotifyApi mobilierNotifyApi = MobilierNotifyApi();
  final EntretienNotifyApi entretienNotifyApi = EntretienNotifyApi();
  final EtatMaterielNotifyApi etatMaterielNotifyApi = EtatMaterielNotifyApi();
  final LogistiqueDepartementNotifyApi logistiqueDepartementNotifyApi =
      LogistiqueDepartementNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  final _itemCountMaterielDG = 0.obs;
  int get itemCountMaterielDG => _itemCountMaterielDG.value;
  final _itemCountMaterielDD = 0.obs;
  int get itemCountMaterielDD => _itemCountMaterielDD.value;

  final _itemCountCarburantDD = 0.obs;
  int get itemCountCarburantDD => _itemCountCarburantDD.value;

  final _itemCountTrajetsDD = 0.obs;
  int get itemCountTrajetsDD => _itemCountTrajetsDD.value;

  final _itemCountImmobilierDG = 0.obs;
  int get itemCountImmobilierDG => _itemCountImmobilierDG.value;
  final _itemCountImmobilierDD = 0.obs;
  int get itemCountImmobilierDD => _itemCountImmobilierDD.value;

  final _itemCountMobilierDD = 0.obs;
  int get itemCountMobilierDD => _itemCountMobilierDD.value;

  final _itemCounEntretienDD = 0.obs;
  int get itemCounEntretienDD => _itemCounEntretienDD.value;

  final _itemCounEtatmaterielDD = 0.obs;
  int get itemCounEtatmaterielDD => _itemCounEtatmaterielDD.value;

  @override
  void onInit() {
    super.onInit();
    getCount();
    getCountEnginDG();
    getCountEnginDD();
    getCountTrajetsDD();
    getCountImmobilierDG();
    getCountImmobilierDD();
    getCountMobilierDD();
    getCountEntretienDD();
    getCountEtatmaterielDD();
  }
 

  void getCount() async {
    NotifySumModel notifySum =
        await logistiqueDepartementNotifyApi.getCountLogistique();
    _itemCount.value = notifySum.sum;
     
  }

  void getCountEnginDG() async {
    NotifyModel notifySum = await materielNotifyApi.getCountDG();
    _itemCountMaterielDG.value = notifySum.count;
     
  }

  void getCountEnginDD() async {
    NotifyModel notifySum = await materielNotifyApi.getCountDD();
    _itemCountMaterielDD.value = notifySum.count;
     
  }

  void getCountTrajetsDD() async {
    NotifyModel notifySum = await trajetNotifyApi.getCountDD();
    _itemCountTrajetsDD.value = notifySum.count;
     
  }

  void getCountImmobilierDG() async {
    NotifyModel notifySum = await immobilierNotifyApi.getCountDG();
    _itemCountImmobilierDG.value = notifySum.count;
     
  }

  void getCountImmobilierDD() async {
    NotifyModel notifySum = await immobilierNotifyApi.getCountDD();
    _itemCountImmobilierDD.value = notifySum.count;
     
  }

  void getCountMobilierDD() async {
    NotifyModel notifySum = await mobilierNotifyApi.getCountDD();
    _itemCountMobilierDD.value = notifySum.count;
     
  }

  void getCountEntretienDD() async {
    NotifyModel notifySum = await entretienNotifyApi.getCountDD();
    _itemCounEntretienDD.value = notifySum.count;
     
  }

  void getCountEtatmaterielDD() async {
    NotifyModel notifySum = await etatMaterielNotifyApi.getCountDD();
    _itemCounEtatmaterielDD.value = notifySum.count;
     
  }
}
