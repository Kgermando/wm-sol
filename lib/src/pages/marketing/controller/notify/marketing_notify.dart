import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/comm_marketing/campaign_notify_api.dart'; 
import 'package:wm_solution/src/api/notifications/departements/comm_marketing_departement.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';

class MarketingNotifyController extends GetxController {
  ComMarketingDepartementNotifyApi comMarketingDepartementNotifyApi =
      ComMarketingDepartementNotifyApi();
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

  @override
  void refresh() {
    getCountComMarketing();
    getCountCampaignDD();
    getCountCampaignBudget();
    getCountCampaignFin();
    getCountCampaignObs();
    super.refresh();
  }

  void getCountComMarketing() async {
    NotifySumModel notifySum =
        await comMarketingDepartementNotifyApi.getCountComMarketing();
    _itemCount.value = notifySum.sum;
  }

  void getCountCampaignDG() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDG();
    _campaignCountDG.value = notifyModel.count;
  }

  void getCountCampaignDD() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountDD(); 
    _campaignCountDD.value = notifyModel.count;
  }

  void getCountCampaignBudget() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountBudget();
    _campaignCountBudget.value = notifyModel.count;
  }

  void getCountCampaignFin() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountFin();
    _campaignCountFin.value = notifyModel.count;
  }

  void getCountCampaignObs() async {
    NotifyModel notifyModel = await campaignNotifyApi.getCountObs();
    _campaignCountObs.value = notifyModel.count;
  }

 

}
