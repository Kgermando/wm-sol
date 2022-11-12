import 'package:get/get.dart';
import 'package:wm_solution/src/api/notifications/comm_marketing/agenda_notify_api.dart';
import 'package:wm_solution/src/api/notifications/comm_marketing/cart_notify_api.dart';
import 'package:wm_solution/src/api/notifications/exploitations/taches_notify_api.dart';
import 'package:wm_solution/src/api/notifications/mails/mails_notify_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';

class NotifyHeaderController extends GetxController {
  final ProfilController profilController = Get.find();
  CartNotifyApi cartNotifyApi = CartNotifyApi();
  TacheNotifyApi tacheNotifyApi = TacheNotifyApi();
  MailsNotifyApi mailsNotifyApi = MailsNotifyApi();
  AgendaNotifyApi agendaNotifyApi = AgendaNotifyApi();

  final _cartItemCount = 0.obs;
  int get cartItemCount => _cartItemCount.value;

  final _tacheItemCount = 0.obs;
  int get tacheItemCount => _tacheItemCount.value;

  final _mailsItemCount = 0.obs;
  int get mailsItemCount => _mailsItemCount.value;

  final _agendaItemCount = 0.obs;
  int get agendaItemCount => _agendaItemCount.value;

  @override
  void onInit() {
    super.onInit();
    getCountCart();
    getCountTache();
    getCountMail();
    getCountAgenda();
  }

  void getCountCart() async {
    NotifyModel notifySum =
        await cartNotifyApi.getCount(profilController.user.matricule);
    _cartItemCount.value = notifySum.count;
    update();
  }

  void getCountTache() async {
    NotifyModel notifySum =
        await tacheNotifyApi.getCount(profilController.user.matricule);
    _tacheItemCount.value = notifySum.count;
    update();
  }

  void getCountMail() async {
    NotifyModel notifySum =
        await mailsNotifyApi.getCount(profilController.user.matricule);
    _mailsItemCount.value = notifySum.count;
    update();
  }

  void getCountAgenda() async {
    NotifyModel notifySum =
        await agendaNotifyApi.getCount(profilController.user.matricule);
    _agendaItemCount.value = notifySum.count;
    update();
  }
}
