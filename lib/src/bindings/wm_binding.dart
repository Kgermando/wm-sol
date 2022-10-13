import 'package:get/get.dart';
import 'package:wm_solution/src/pages/budgets/controller/notify/budget_notify_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/compaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/balance/balance_ref_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/bilan_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/bilans/compte_bilan_ref_controller.dart';
import 'package:wm_solution/src/pages/comptabilites/controller/notify/notify_comptabilite.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_controller.dart';
import 'package:wm_solution/src/pages/devis/controller/devis_list_objet_controller.dart';
import 'package:wm_solution/src/pages/exploitations/controller/projets/projet_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/notify/rh_notify_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/forgot_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/change_password_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/login_controller.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/budget_previsionnel_controller.dart';
import 'package:wm_solution/src/pages/budgets/controller/ligne_budgetaire_controller.dart';
import 'package:wm_solution/src/pages/mailling/controller/mailling_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/performences/performence_note_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/presences/presence_personne_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/salaires/salaire_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/transport_rest/transport_rest_person_controller.dart';

class WMBindings extends Bindings {
  @override
  void dependencies() {  
    // Mail
    Get.lazyPut<MaillingController>(() => MaillingController());

    // Authentification
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    // RH
    Get.lazyPut<RHNotifyController>(() => RHNotifyController());
    Get.lazyPut<PersonnelsController>(() => PersonnelsController());
    Get.lazyPut<SalaireController>(() => SalaireController());
    Get.lazyPut<TransportRestController>(() => TransportRestController());
    Get.lazyPut<TransportRestPersonnelsController>(() => TransportRestPersonnelsController());
    Get.lazyPut<PerformenceController>(() => PerformenceController());
    Get.lazyPut<PerformenceNoteController>(() => PerformenceNoteController());
    Get.lazyPut<UsersController>(() => UsersController());
    Get.lazyPut<PresenceController>(() => PresenceController());
    Get.lazyPut<PresencePersonneController>(() => PresencePersonneController());
    
    Get.lazyPut<SalaireController>(() => SalaireController());
    Get.lazyPut<SalaireController>(() => SalaireController());


  // Budgets
  Get.lazyPut<BudgetNotifyController>(() => BudgetNotifyController());
  Get.lazyPut<BudgetPrevisionnelController>(
      () => BudgetPrevisionnelController());
  Get.lazyPut<LignBudgetaireController>(() => LignBudgetaireController());

  // Comptabilites
  Get.lazyPut<ComptabiliteNotifyController>(() => ComptabiliteNotifyController());
  Get.lazyPut<BalanceController>(() => BalanceController());
  Get.lazyPut<BalanceRefController>(() => BalanceRefController());
  Get.lazyPut<BilanController>(() => BilanController());
  Get.lazyPut<CompteBilanRefController>(() => CompteBilanRefController());


  // Exploitations
  Get.lazyPut<ProjetController>(() => ProjetController());
  Get.lazyPut<SuccursaleController>(() => SuccursaleController());
  Get.lazyPut<SuccursaleController>(() => SuccursaleController());
  Get.lazyPut<SuccursaleController>(() => SuccursaleController());

  // Commercial & Marketing
  Get.lazyPut<CampaignController>(() => CampaignController());
  Get.lazyPut<SuccursaleController>(() => SuccursaleController());

    // Devis
    Get.lazyPut<DevisController>(() => DevisController());
    Get.lazyPut<DevisListObjetController>(() => DevisListObjetController());
    
  }
}
