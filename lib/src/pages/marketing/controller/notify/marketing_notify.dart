import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/comm_marketing/campaign_notify_api.dart';
import 'package:wm_solution/src/api/notifications/departements/marketing_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class MarketingNotifyController extends GetxController {
  MarketingDepartementNotifyApi marketingDepartementNotifyApi =
      MarketingDepartementNotifyApi();
  CampaignNotifyApi campaignNotifyApi = CampaignNotifyApi();

  final _itemCount = '0'.obs;
  String get itemCount => _itemCount.value;

  final _campaignCountDG = 0.obs;
  int get campaignCountDG => _campaignCountDG.value;
  final _campaignCountDD = 0.obs;
  int get campaignCountDD => _campaignCountDD.value;
  final _campaignCountBudget = 0.obs;
  int get campaignCountBudget => _campaignCountBudget.value;
  final _campaignCountFin = 0.obs;
  int get campaignCountFin => _campaignCountFin.value;
  final _campaignCountObs = 0.obs;
  int get campaignCountObs => _campaignCountObs.value;
 
  

  @override
  void onInit() {
    super.onInit(); 
    getCountComMarketing();
        getCountCampaignDD();
        getCountCampaignBudget();
        getCountCampaignFin();
        getCountCampaignObs();
  }

  


  void getCountComMarketing() async {
    NotifySumModel notifySum =
        await marketingDepartementNotifyApi.getCountMarketing();
    _campaignCountDG.value = 0;
    _itemCount.value = notifySum.sum;
    update();
  }

  void getCountCampaignDG() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDG();
    _campaignCountDG.value = 0;
    _campaignCountDG.value = notifyModel.count;
    update();
  }

  void getCountCampaignDD() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDD();
    _campaignCountDG.value = 0;
    _campaignCountDD.value = notifyModel.count;
    update();
  }

  void getCountCampaignBudget() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountBudget();
    _campaignCountDG.value = 0;
    _campaignCountBudget.value = notifyModel.count;
    update();
  }

  void getCountCampaignFin() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountFin();
    _campaignCountDG.value = 0;
    _campaignCountFin.value = notifyModel.count;
    update();
  }

  void getCountCampaignObs() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountObs();
    _campaignCountDG.value = 0;
    _campaignCountObs.value = notifyModel.count;
    update();
  }
}
