import 'package:get/get.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/achat_model.dart';
import 'package:wm_solution/src/models/comm_maketing/agenda_model.dart';
import 'package:wm_solution/src/models/comm_maketing/annuaire_model.dart';
import 'package:wm_solution/src/models/comm_maketing/bon_livraison.dart';
import 'package:wm_solution/src/models/comm_maketing/campaign_model.dart';
import 'package:wm_solution/src/models/comm_maketing/cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/creance_cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/facture_cart_model.dart';
import 'package:wm_solution/src/models/comm_maketing/prod_model.dart';
import 'package:wm_solution/src/models/comm_maketing/restitution_model.dart';
import 'package:wm_solution/src/models/comm_maketing/stocks_global_model.dart';
import 'package:wm_solution/src/models/comm_maketing/succursale_model.dart';
import 'package:wm_solution/src/models/comptabilites/balance_comptes_model.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/models/comptabilites/compte_resultat_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_livre_model.dart';
import 'package:wm_solution/src/models/comptabilites/journal_model.dart';
import 'package:wm_solution/src/models/devis/devis_models.dart';
import 'package:wm_solution/src/models/exploitations/fourniseur_model.dart';
import 'package:wm_solution/src/models/exploitations/production_model.dart';
import 'package:wm_solution/src/models/exploitations/projet_model.dart';
import 'package:wm_solution/src/models/logistiques/anguin_model.dart';
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/models/logistiques/carburant_model.dart';
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:wm_solution/src/models/logistiques/mobilier_model.dart';
import 'package:wm_solution/src/models/logistiques/trajet_model.dart';
import 'package:wm_solution/src/models/mail/mail_model.dart';
import 'package:wm_solution/src/models/taches/rapport_model.dart';
import 'package:wm_solution/src/models/taches/tache_model.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:wm_solution/src/models/finances/banque_name_model.dart';
import 'package:wm_solution/src/models/finances/caisse_model.dart';
import 'package:wm_solution/src/models/finances/caisse_name_model.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:wm_solution/src/models/finances/dette_model.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_model.dart';
import 'package:wm_solution/src/models/finances/fin_exterieur_name_model.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/models/rh/paiement_salaire_model.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:wm_solution/src/models/rh/presence_model.dart';
import 'package:wm_solution/src/models/rh/transport_restauration_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/administration/view/admin_budget.dart';
import 'package:wm_solution/src/pages/administration/view/admin_comm_marketing.dart';
import 'package:wm_solution/src/pages/administration/view/admin_dashboard.dart';
import 'package:wm_solution/src/pages/administration/view/admin_exploitation.dart';
import 'package:wm_solution/src/pages/administration/view/admin_finance.dart';
import 'package:wm_solution/src/pages/administration/view/admin_logistique.dart';
import 'package:wm_solution/src/pages/administration/view/admin_rh.dart';
import 'package:wm_solution/src/pages/archives/components/add_archive.dart';
import 'package:wm_solution/src/pages/archives/components/archive_pdf_viewer.dart';
import 'package:wm_solution/src/pages/archives/components/detail_archive.dart';
import 'package:wm_solution/src/pages/archives/views/archive_folder_page.dart';
import 'package:wm_solution/src/pages/archives/views/archives.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/detail_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/ajout_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/detail_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/view/budget_previsionnel_page.dart';
import 'package:wm_solution/src/pages/budgets/view/dashboard_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/dd_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/historique_budgets.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/achats/detail_achat.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/bon_livraison/detail_bon_livraison.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/cart/detail_cart.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/detail_facture.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/factures/detail_facture_creance.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/produit_model/ajout_product_model.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/produit_model/detail_product_model.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/produit_model/update_product_modele_controller.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/restitution/detail_restitution.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/stock_global/add_stock_global.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/stock_global/detail_stock_global.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/stock_global/livraison_stock.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/stock_global/ravitaillement_stock.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/succursale/add_succursale.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/succursale/detail_succursale.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/commercials/succursale/update_succursale.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/agenda/detail_agenda.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/agenda/update_agenda.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/annuaire/add_annuaire.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/annuaire/detail_anniuaire.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/annuaire/update_annuaire.dart';
import 'package:wm_solution/src/pages/commercial_marketing/components/marketing/campaigns/detail_campaign.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/com_marketing_dd/comm_marketing_dd.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/achat_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/bon_livraison_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/cart_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/facture_creance_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/facture_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/history_livraison_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/history_ravitaillement_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/produit_model_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/restitution_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/stock_global_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/succursale_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/commercials/vente_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/dashboard/dashboard_comm_marketing_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/marketing/agenda_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/marketing/annuaire_page.dart';
import 'package:wm_solution/src/pages/commercial_marketing/view/marketing/campaign_page.dart';
import 'package:wm_solution/src/pages/comptabilites/components/balance/detail_balance.dart';
import 'package:wm_solution/src/pages/comptabilites/components/bilan/detail_bilan.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/add_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/detail_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/update_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/detail_journal_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/components/journals/search_grand_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/view/balance_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/bilan_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/compte_resultat_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/dashboard_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/dd_comptabilie.dart';
import 'package:wm_solution/src/pages/comptabilites/view/grand_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/view/journal_livre_comptabilite.dart';
import 'package:wm_solution/src/pages/devis/components/detail_devis.dart';
import 'package:wm_solution/src/pages/devis/view/devis_page.dart';
import 'package:wm_solution/src/pages/exploitations/components/fournisseurs/detail_fournisseur.dart';
import 'package:wm_solution/src/pages/exploitations/components/productions/detail_production_exp.dart';
import 'package:wm_solution/src/pages/exploitations/components/projets/add_projet.dart';
import 'package:wm_solution/src/pages/exploitations/components/projets/detail_projet.dart';
import 'package:wm_solution/src/pages/exploitations/components/projets/update_projet.dart';
import 'package:wm_solution/src/pages/exploitations/view/dashboard_exp.dart';
import 'package:wm_solution/src/pages/exploitations/view/exp_dd.dart';
import 'package:wm_solution/src/pages/exploitations/view/fournisseurs_page.dart';
import 'package:wm_solution/src/pages/exploitations/view/production_exp_page.dart';
import 'package:wm_solution/src/pages/exploitations/view/projet_page.dart';
import 'package:wm_solution/src/pages/finances/components/banques/detail_banque.dart';
import 'package:wm_solution/src/pages/finances/components/caisses/detail_caisse.dart';
import 'package:wm_solution/src/pages/finances/components/creances/detail_creance.dart';
import 'package:wm_solution/src/pages/finances/components/dettes/detail_dette.dart';
import 'package:wm_solution/src/pages/finances/components/fin_exterieur/detail_fin_exterieur.dart';
import 'package:wm_solution/src/pages/finances/view/banque_page.dart';
import 'package:wm_solution/src/pages/finances/view/caisse_page.dart';
import 'package:wm_solution/src/pages/finances/view/creance_page.dart';
import 'package:wm_solution/src/pages/finances/view/dashboard_finance.dart';
import 'package:wm_solution/src/pages/finances/view/dd_finance.dart';
import 'package:wm_solution/src/pages/finances/view/dette_page.dart';
import 'package:wm_solution/src/pages/finances/view/fin_exterieur_page.dart';
import 'package:wm_solution/src/pages/finances/view/observation_page.dart';
import 'package:wm_solution/src/pages/logistique/components/approvisionnements/detail_accuse_reception.dart';
import 'package:wm_solution/src/pages/logistique/components/approvisionnements/detail_approvisionnement.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/carburants/add_carburant.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/carburants/detail_carburant.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/engins/add_engin.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/engins/detail_engin.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/trajets/add_trajet.dart';
import 'package:wm_solution/src/pages/logistique/components/automobiles/trajets/detail_trajet.dart';
import 'package:wm_solution/src/pages/logistique/components/entretiens/add_entretien.dart';
import 'package:wm_solution/src/pages/logistique/components/entretiens/detail_entretien.dart';
import 'package:wm_solution/src/pages/logistique/components/etat_materiels/add_etat_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/etat_materiels/detail_etat_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/etat_materiels/update_etat_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/immobiliers/detail_immobilier.dart';
import 'package:wm_solution/src/pages/logistique/components/immobiliers/update_immobilier.dart';
import 'package:wm_solution/src/pages/logistique/components/mobiliers/detail_mobilier.dart';
import 'package:wm_solution/src/pages/logistique/components/mobiliers/update_mobilier.dart';
import 'package:wm_solution/src/pages/logistique/view/accuser_reception_page.dart';
import 'package:wm_solution/src/pages/logistique/view/approvisionnement_page.dart';
import 'package:wm_solution/src/pages/logistique/view/carburant_page.dart';
import 'package:wm_solution/src/pages/logistique/view/dahsboard_log.dart';
import 'package:wm_solution/src/pages/logistique/view/engin_page.dart';
import 'package:wm_solution/src/pages/logistique/view/entretiens_page.dart';
import 'package:wm_solution/src/pages/logistique/view/etat_materiel_page.dart';
import 'package:wm_solution/src/pages/logistique/view/immobilier_page.dart';
import 'package:wm_solution/src/pages/logistique/view/log_dd.dart';
import 'package:wm_solution/src/pages/logistique/view/mobilier_page.dart';
import 'package:wm_solution/src/pages/logistique/view/trajet_page.dart';
import 'package:wm_solution/src/pages/mailling/components/detail_mail.dart';
import 'package:wm_solution/src/pages/mailling/view/mail_send.dart';
import 'package:wm_solution/src/pages/mailling/components/new_mail.dart';
import 'package:wm_solution/src/pages/mailling/components/repondre_mail.dart';
import 'package:wm_solution/src/pages/mailling/components/tranfert_mail.dart';
import 'package:wm_solution/src/pages/mailling/view/mails_page.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/dd_rh/users_actifs/detail._user.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/add_performence_note.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/performences/detail_performence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/add_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/detail_personne.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/personnels/update_personnel.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/presences/detail_presence.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/add_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/salaires/bulletin_salaire.dart';
import 'package:wm_solution/src/pages/ressource_humaines/components/transport_restauration/detail_transport_rest.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/dashboard_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/dd_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/performence_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/personnels_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/presence_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/salaires_rh.dart';
import 'package:wm_solution/src/pages/ressource_humaines/view/transport_restauration_rh.dart';
import 'package:wm_solution/src/pages/taches/components/add_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_tache.dart';
import 'package:wm_solution/src/pages/taches/view/tache_page.dart';
import 'package:wm_solution/src/pages/update/view/update_page.dart';
import 'package:wm_solution/src/routes/routes.dart';

List<GetPage<dynamic>>? getPages = [
  // Settings
  // GetPage(name: SettingsRoutes.helps, page: page),
  // GetPage(name: SettingsRoutes.settings, page: page),
  // GetPage(name: SettingsRoutes.pageVerrouillage, page: page),
  // GetPage(name: SettingsRoutes.splash, page: page),

  // Mails
   GetPage(
      name: MailRoutes.mails,
      page: () => const MailPages(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.addMail,
      page: () => const NewMail(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailSend,
      page: () => const MailSend(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: MailRoutes.mailDetail,
    page: () {
      MailColor mailColor = Get.arguments as MailColor;
      return DetailMail(mailColor: mailColor);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailRepondre,
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return RepondreMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailTransfert,
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return TransfertMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Taches & Rapports
  GetPage(
      name: TacheRoutes.tachePage,
      page: () => const TachePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.tacheDetail,
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return DetailTache(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportDetail,
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return DetailTache(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportDetail,
      page: () {
        RapportModel rapportModel = Get.arguments as RapportModel;
        return DetailRapport(rapportModel: rapportModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportAdd,
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return AddRapport(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Archives
  GetPage(
      name: ArchiveRoutes.archives,
      page: () => const ArchiveFolderPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archiveTable,
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return ArchiveData(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.addArchives,
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return AddArchive(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivesDetail,
      page: () {
        ArchiveModel archiveModel = Get.arguments as ArchiveModel;
        return DetailArchive(archiveModel: archiveModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivePdf,
      page: () {
        String url = Get.arguments as String;
        return ArchivePdfViewer(url: url);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // UserRoutes
  GetPage(name: UserRoutes.login, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.logout, page: () => const LoginAuth()),
  GetPage(name: UserRoutes.profil, page: () => const ProfileAuth()),
  GetPage(name: UserRoutes.forgotPassword, page: () => const ProfileAuth()),
  GetPage(
      name: UserRoutes.changePassword, page: () => const ChangePasswordAuth()),

  // RH
  GetPage(
      name: RhRoutes.rhDashboard,
      page: () => const DashboardRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhDD,
      page: () => const DDRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsPage,
      page: () => const PersonnelsPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsAdd,
      page: () {
        List<AgentModel> personnelList = Get.arguments as List<AgentModel>;
        return AddPersonnel(personnelList: personnelList);
      }),
  GetPage(
      name: RhRoutes.rhPersonnelsDetail,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return DetailPersonne(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsUpdate,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return UpdatePersonnel(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiement,
      page: () => const SalairesRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementBulletin,
      page: () {
        PaiementSalaireModel salaire = Get.arguments as PaiementSalaireModel;
        return BulletinSalaire(salaire: salaire);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementAdd,
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return AddSalaire(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhTransportRest,
      page: () => const TransportRestaurationRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhTransportRestDetail,
      page: () {
        TransportRestaurationModel transportRestaurationModel =
            Get.arguments as TransportRestaurationModel;
        return DetailTransportRest(
            transportRestaurationModel: transportRestaurationModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPerformence,
      page: () => const PerformenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceDetail,
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return DetailPerformence(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceAddNote,
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return AddPerformenceNote(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPresence,
      page: () => const PresenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPresenceDetail,
      page: () {
        final PresenceModel presenceModel = Get.arguments as PresenceModel;
        return DetailPresence(presenceModel: presenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhdetailUser,
      page: () {
        final UserModel userModel = Get.arguments as UserModel;
        return DetailUser(user: userModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Budgets
  GetPage(
      name: BudgetRoutes.budgetDashboard,
      page: () => const DashboardBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetDD,
      page: () => const DDBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionel,
      page: () => const BudgetPrevisionnelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.historiqueBudgetPrevisionel,
      page: () => const HistoriqueBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionelDetail,
      page: () {
        final DepartementBudgetModel departementBudgetModel =
            Get.arguments as DepartementBudgetModel;
        return DetailBudgetPrevisionnel(
            departementBudgetModel: departementBudgetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetLignebudgetaireDetail, 
      page: () {
        final LigneBudgetaireModel ligneBudgetaireModel =
            Get.arguments as LigneBudgetaireModel;
        return DetailLigneBudgetaire(
            ligneBudgetaireModel: ligneBudgetaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetLignebudgetaireAdd,
      page: () {
        final DepartementBudgetModel departementBudgetModel =
            Get.arguments as DepartementBudgetModel;
        return AjoutLigneBudgetaire(
            departementBudgetModel: departementBudgetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Comptabilites
  GetPage(
      name: ComptabiliteRoutes.comptabiliteDashboard,
      page: () => const DashboardComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteDD,
      page: () => const DDComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalance,
      page: () => const BalanceComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalanceDetail,
      page: () {
        final BalanceCompteModel balanceCompteModel =
            Get.arguments as BalanceCompteModel;
        return DetailBalance(balanceCompteModel: balanceCompteModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilan,
      page: () => const BilanComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilanDetail,
      page: () {
        final BilanModel bilanModel = Get.arguments as BilanModel;
        return DetailBilan(bilanModel: bilanModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultat,
      page: () => const CompteResultatComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatDetail,
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return DetailCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatAdd,
      page: () => const AddCompteResultat(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatUpdate,
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return UpdateCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteJournalLivre,
      page: () => const JournalLivreComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteJournalDetail,
      page: () {
        final JournalLivreModel journalLivreModel =
            Get.arguments as JournalLivreModel;
        return DetailJournalLivre(journalLivreModel: journalLivreModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivre,
      page: () => const GrandLivre(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivreSearch,
      page: () {
        final List<JournalModel> search = Get.arguments as List<JournalModel>;
        return SearchGrandLivre(search: search);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // DevisRoutes
  GetPage(
      name: DevisRoutes.devis,
      page: () => const DevisPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: DevisRoutes.devisDetail,
      page: () {
        final DevisModel devisModel = Get.arguments as DevisModel;
        return DetailDevis(devisModel: devisModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Finances
  GetPage(
      name: FinanceRoutes.financeDashboard,
      page: () => const DashboadFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.finDD,
      page: () => const DDFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.finObservation,
      page: () => const ObservationPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-banque/:id',
      page: () {
        final BanqueNameModel banqueNameModel =
            Get.arguments as BanqueNameModel;
        return BanquePage(banqueNameModel: banqueNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsBanqueDetail,
      page: () {
        final BanqueModel banqueModel = Get.arguments as BanqueModel;
        return DetailBanque(banqueModel: banqueModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-caisse/:id',
      page: () {
        final CaisseNameModel caisseNameModel =
            Get.arguments as CaisseNameModel;
        return CaissePage(caisseNameModel: caisseNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCaisseDetail,
      page: () {
        final CaisseModel caisseModel = Get.arguments as CaisseModel;
        return DetailCaisse(caisseModel: caisseModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreances,
      page: () => const CreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreanceDetail,
      page: () {
        final CreanceModel creanceModel = Get.arguments as CreanceModel;
        return DetailCreance(creanceModel: creanceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsDettes,
      page: () => const DettePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsDetteDetail,
      page: () {
        final DetteModel detteModel = Get.arguments as DetteModel;
        return DetailDette(detteModel: detteModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-financement-externe/:id',
      page: () {
        final FinExterieurNameModel finExterieurNameModel =
            Get.arguments as FinExterieurNameModel;
        return FinExterieurPage(finExterieurNameModel: finExterieurNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsFinancementExterneDetail,
      page: () {
        final FinanceExterieurModel financeExterieurModel =
            Get.arguments as FinanceExterieurModel;
        return DetailFinExterieur(financeExterieurModel: financeExterieurModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // Marketing
  GetPage(
      name: ComMarketingRoutes.comMarketingCampaign,
      page: () => const CampaignPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingCampaignDetail,
      page: () {
        final CampaignModel campaignModel = Get.arguments as CampaignModel;
        return DetailCampaign(campaignModel: campaignModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingAnnuaire,
      page: () => const AnnuairePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAnnuaireAdd,
      page: () => const AddAnnuaire(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAnnuaireDetail,
      page: () {
        final AnnuaireColor annuaireColor = Get.arguments as AnnuaireColor;
        return DetailAnnuaire(annuaireColor: annuaireColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAnnuaireEdit,
      page: () {
        final AnnuaireModel annuaireModel = Get.arguments as AnnuaireModel;
        return UpdateAnnuaire(annuaireModel: annuaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingAgenda,
      page: () => const AgendaPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAgendaDetail,
      page: () {
        final AgendaColor agendaColor = Get.arguments as AgendaColor;
        return DetailAgenda(agendaColor: agendaColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAgendaUpdate,
      page: () {
        final AgendaColor agendaColor = Get.arguments as AgendaColor;
        return UpdateAgenda(agendaColor: agendaColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  // Commercial
  GetPage(
    name: ComMarketingRoutes.comMarketingDashboard,
    page: () => const DashboardCommMarketingPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingDD,
      page: () => const CommMarketingDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingSuccursale,
      page: () => const SuccursalePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComMarketingRoutes.comMarketingSuccursaleAdd,
    page: () => const AddSuccursale(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComMarketingRoutes.comMarketingAgendaDetail,
    page: () {
      final SuccursaleModel succursaleModel = Get.arguments as SuccursaleModel;
      return DetailSuccursale(succursaleModel: succursaleModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComMarketingRoutes.comMarketingAgendaUpdate,
    page: () {
      final SuccursaleModel succursaleModel =
          Get.arguments as SuccursaleModel;
      return UpdateSuccursale(succursaleModel: succursaleModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingVente,
      page: () => const VentePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)), 

  
  GetPage(
    name: ComMarketingRoutes.comMarketingStockGlobal,
    page: () => const StockGlobalPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComMarketingRoutes.comMarketingStockGlobalAdd,
    page: () => const AddStockGlobal(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComMarketingRoutes.comMarketingStockGlobalDetail,
    page: () {
      final StocksGlobalMOdel stocksGlobalMOdel =
          Get.arguments as StocksGlobalMOdel;
      return DetailStockGlobal(stocksGlobalMOdel: stocksGlobalMOdel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingStockGlobalLivraisonStock,
      page: () {
        final StocksGlobalMOdel stocksGlobalMOdel =
            Get.arguments as StocksGlobalMOdel;
        return LivraisonStock(stocksGlobalMOdel: stocksGlobalMOdel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingStockGlobalRavitaillement,
      page: () {
        final StocksGlobalMOdel stocksGlobalMOdel =
            Get.arguments as StocksGlobalMOdel;
        return RavitaillementStock(stocksGlobalMOdel: stocksGlobalMOdel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),


  GetPage(  
    name: ComMarketingRoutes.comMarketingRestitution,
    page: () => const RestitutionPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingRestitutionDetail,
      page: () {
        final RestitutionModel restitutionModel =
            Get.arguments as RestitutionModel;
        return DetailRestitution(restitutionModel: restitutionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
    
   GetPage(
      name: ComMarketingRoutes.comMarketingProduitModel,
      page: () => const ProduitModelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingProduitModelAdd,
      page: () => const AjoutProductModel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingProduitModelDetail,
      page: () {
        final ProductModel productModel =
            Get.arguments as ProductModel;
        return DetailProductModel(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingProduitModelUpdate,
      page: () {
        final ProductModel productModel = Get.arguments as ProductModel;
        return UpdateProductModele(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingHistoryRavitaillement,
      page: () => const HistoryRavitaillementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingHistoryLivraison,
      page: () => const HistoryLivraisonPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingFacture,
      page: () => const FacturePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingCreance,
      page: () => const FactureCreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingFactureDetail,
      page: () {
        final FactureCartModel factureCartModel = Get.arguments as FactureCartModel;
        return DetailFacture(factureCartModel: factureCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingCreanceDetail,
      page: () {
        final CreanceCartModel creanceCartModel =
            Get.arguments as CreanceCartModel;
        return DetailFactureCreance(creanceCartModel: creanceCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingcart,
      page: () => const CartPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingcartDetail,
      page: () {
        final CartModel cart =
            Get.arguments as CartModel;
        return DetailCart(cart: cart);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComMarketingRoutes.comMarketingBonLivraison,
      page: () => const BonLivraisonPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingBonLivraisonDetail,
      page: () {
        final BonLivraisonModel bonLivraisonModel = Get.arguments as BonLivraisonModel;
        return DetailBonLivraison(bonLivraisonModel: bonLivraisonModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
    name: ComMarketingRoutes.comMarketingAchat,
    page: () => const AchatPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComMarketingRoutes.comMarketingAchatDetail,
      page: () {
        final AchatModel achatModel =
            Get.arguments as AchatModel;
        return DetailAchat(achatModel: achatModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  // Exploitations
  GetPage(
    name: ExploitationRoutes.expDashboard,
    page: () => const DashboardExp(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expDD,
      page: () => const ExpDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expFournisseur,
      page: () => const FournisseursPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ExploitationRoutes.expFournisseurDetail,
    page: () {
      final FournisseurModel fournisseurModel = Get.arguments as FournisseurModel;
      return DetailFournisseur(fournisseurModel: fournisseurModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expProd,
      page: () => const ProductionExpPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProdDetail,
      page: () {
        final ProductionModel productionModel =
            Get.arguments as ProductionModel;
        return DetailProductionExp(productionModel: productionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  GetPage(
    name: ExploitationRoutes.expProjet,
    page: () => const ProjetPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ExploitationRoutes.expProjetAdd,
    page: () => const AddProjet(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ExploitationRoutes.expProjetDetail,
    page: () {
      final ProjetModel projetModel =
          Get.arguments as ProjetModel;
      return DetailProjet(projetModel: projetModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetDetail,
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return DetailProjet(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetUpdate,
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return UpdateProjet(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Logistique
    GetPage(
      name: LogistiqueRoutes.logDashboard,
      page: () => const DashboardLog(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
    GetPage(
      name: LogistiqueRoutes.logDD,
      page: () => const LogDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

    GetPage(
      name: LogistiqueRoutes.logAnguinAuto,
      page: () => const EnginPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddAnguinAuto,
      page: () => const AddEngin(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAnguinAutoDetail,
      page: () {
        final AnguinModel anguinModel = Get.arguments as AnguinModel;
        return DetailEngin(anguinModel: anguinModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
    name: LogistiqueRoutes.logCarburantAuto,
    page: () => const CarburantPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddCarburantAuto,
      page: () => const AddCarburant(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logCarburantAutoDetail,
      page: () {
        final CarburantModel carburantModel = Get.arguments as CarburantModel;
        return DetailCarburant(carburantModel: carburantModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)), 

   GetPage(
      name: LogistiqueRoutes.logTrajetAuto,
      page: () => const TrajetPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddTrajetAuto,
      page: () {
        final AnguinModel anguinModel = Get.arguments as AnguinModel;
        return AddTrajet(anguinModel: anguinModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddTrajetAuto,
      page: () {
        final TrajetModel trajetModel = Get.arguments as TrajetModel;
        return DetailTrajet(trajetModel: trajetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  GetPage(
      name: LogistiqueRoutes.logEntretien,
      page: () => const EntretiensPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddEntretien,
      page: () => const AddEntretien(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEntretienDetail,
      page: () {
        final EntretienModel entretienModel = Get.arguments as EntretienModel;
        return DetailEntretien(entretienModel: entretienModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEtatMateriel,
      page: () => const EtatMaterielPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddEtatMateriel,
      page: () => const AddEtatMateriel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEtatMaterielDetail,
      page: () {
        final EtatMaterielModel etatMaterielModel = Get.arguments as EtatMaterielModel;
        return DetailEtatMateriel(etatMaterielModel: etatMaterielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEtatMaterielUpdate,
      page: () {
        final EtatMaterielModel etatMaterielModel =
            Get.arguments as EtatMaterielModel;
        return UpdateEtatMateriel(etatMaterielModel: etatMaterielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logImmobilierMateriel,
      page: () => const ImmobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielDetail,
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return DetailImmobilier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielUpdate,
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return UpdateImmobimier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  GetPage(
      name: LogistiqueRoutes.logMobilierMateriel,
      page: () => const MobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielDetail,
      page: () {
        final MobilierModel mobilierModel =
            Get.arguments as MobilierModel;
        return DetailMobiler(mobilierModel: mobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielUpdate,
      page: () {
        final MobilierModel mobilierModel = Get.arguments as MobilierModel;
        return UpdateMobilier(mobilierModel: mobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionnement,
      page: () => const ApprovisionnementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionnementDetail,
      page: () {
        final ApprovisionnementModel approvisionnementModel = 
          Get.arguments as ApprovisionnementModel;
        return DetailApprovisionnement(approvisionnementModel: approvisionnementModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionReception,
      page: () => const AccuseReceptionPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionnementDetail,
      page: () {
        final ApprovisionReceptionModel approvisionReceptionModel =
            Get.arguments as ApprovisionReceptionModel;
        return DetailAccuseReception(approvisionReceptionModel: approvisionReceptionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

    
  // Administration
  GetPage(
    name: AdminRoutes.adminDashboard,
    page: () => const AdminDashboard(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminBudget,
      page: () => const AdminBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminCommMarketing,
      page: () => const AdminCommMarketing(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminExploitation,
      page: () => const AdminExploitation(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminFinance,
      page: () => const AdminFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminLogistique,
      page: () => const AdminLogistique(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminRH,
      page: () => const AdminRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

    // Update version
    GetPage(
      name: UpdateRoutes.updatePage,
      page: () => const UpdatePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
];
