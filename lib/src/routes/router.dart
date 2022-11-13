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
import 'package:wm_solution/src/models/exploitations/versement_projet_model.dart';
import 'package:wm_solution/src/models/logistiques/approvision_reception_model.dart';
import 'package:wm_solution/src/models/logistiques/approvisionnement_model.dart';
import 'package:wm_solution/src/models/logistiques/entretien_model.dart';
import 'package:wm_solution/src/models/logistiques/etat_materiel_model.dart';
import 'package:wm_solution/src/models/logistiques/immobilier_model.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';
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
import 'package:wm_solution/src/pages/administration/bindings/admin_dashboard_binding.dart';
import 'package:wm_solution/src/pages/administration/view/admin_budget.dart';
import 'package:wm_solution/src/pages/administration/view/admin_comm.dart';
import 'package:wm_solution/src/pages/administration/view/admin_dashboard.dart';
import 'package:wm_solution/src/pages/administration/view/admin_exploitation.dart';
import 'package:wm_solution/src/pages/administration/view/admin_finance.dart';
import 'package:wm_solution/src/pages/administration/view/admin_logistique.dart';
import 'package:wm_solution/src/pages/administration/view/admin_marketing.dart';
import 'package:wm_solution/src/pages/administration/view/admin_rh.dart';
import 'package:wm_solution/src/pages/archives/bindings/archive_binding.dart';
import 'package:wm_solution/src/pages/archives/bindings/archive_folder_binding.dart';
import 'package:wm_solution/src/pages/archives/components/add_archive.dart';
import 'package:wm_solution/src/pages/archives/components/archive_pdf_viewer.dart';
import 'package:wm_solution/src/pages/archives/components/detail_archive.dart';
import 'package:wm_solution/src/pages/archives/views/archive_folder_page.dart';
import 'package:wm_solution/src/pages/archives/views/archives.dart';
import 'package:wm_solution/src/pages/auth/bindings/change_password_binding.dart';
import 'package:wm_solution/src/pages/auth/bindings/forgot_forgot_password_binding.dart';
import 'package:wm_solution/src/pages/auth/bindings/login_binding.dart';
import 'package:wm_solution/src/pages/auth/bindings/profil_binding.dart';
import 'package:wm_solution/src/pages/auth/view/forgot_password.dart';
import 'package:wm_solution/src/pages/auth/view/login_auth.dart';
import 'package:wm_solution/src/pages/auth/view/change_password_auth.dart';
import 'package:wm_solution/src/pages/auth/view/profil_auth.dart';
import 'package:wm_solution/src/pages/budgets/bindings/budget_previsionnel_binding.dart';
import 'package:wm_solution/src/pages/budgets/bindings/dashboard_budget_binding.dart';
import 'package:wm_solution/src/pages/budgets/bindings/ligne_budgetaire_binding.dart';
import 'package:wm_solution/src/pages/budgets/components/budget_previsionnel/detail_budget_previsionnel.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/ajout_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/components/ligne_budgetaire/detail_ligne_budgetaire.dart';
import 'package:wm_solution/src/pages/budgets/view/budget_previsionnel_page.dart';
import 'package:wm_solution/src/pages/budgets/view/dashboard_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/dd_budget.dart';
import 'package:wm_solution/src/pages/budgets/view/historique_budgets.dart';
import 'package:wm_solution/src/pages/commercial/bindings/Gain_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/achat_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/bon_livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/cart_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/dashboard_com_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/facture_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/facture_creance_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/history_livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/history_ravitaillement_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/numero_facture_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/produit_model_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ravitaillement_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/restitution_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/stock_global_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/succursale_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/vente_cart_binding.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/achats/detail_achat.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/bon_livraison/detail_bon_livraison.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/cart/detail_cart.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/factures/detail_facture.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/factures/detail_facture_creance.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/produit_model/ajout_product_model.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/produit_model/detail_product_model.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/produit_model/update_product_modele_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/restitution/detail_restitution.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/stock_global/add_stock_global.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/stock_global/detail_stock_global.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/stock_global/livraison_stock.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/stock_global/ravitaillement_stock.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/succursale/add_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/succursale/detail_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/commercials/succursale/update_succursale.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/balance_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/balance_ref_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/bilan_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/bilan_ref_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/compte_resultat_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/dashboard_comptabilite_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/journal_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/journal_livre_binding.dart';
import 'package:wm_solution/src/pages/devis/bindings/devis_binding.dart';
import 'package:wm_solution/src/pages/devis/bindings/devis_list_objet_binding.dart';
import 'package:wm_solution/src/pages/exploitations/bindings/dashboard_exploitation_binding.dart';
import 'package:wm_solution/src/pages/exploitations/bindings/fournisseur_binding.dart';
import 'package:wm_solution/src/pages/exploitations/bindings/production_exp_binding.dart';
import 'package:wm_solution/src/pages/exploitations/bindings/projet_binding.dart';
import 'package:wm_solution/src/pages/exploitations/bindings/versement_binding.dart';
import 'package:wm_solution/src/pages/exploitations/components/versements/add_versement.dart';
import 'package:wm_solution/src/pages/exploitations/components/versements/detail_vesement.dart';
import 'package:wm_solution/src/pages/exploitations/view/versement_page.dart';
import 'package:wm_solution/src/pages/finances/bindings/banque_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/banque_name_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/caisse_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/caisse_name_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/creance_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/creance_dette_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/dashboard_finance_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/dette_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/fin_exterieur_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/fin_exterieur_name_binding.dart';
import 'package:wm_solution/src/pages/finances/bindings/observation_notify_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/approvision_reception_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/approvisionnment_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/dashboard_log_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/entretien_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/etat_materiel_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/immobilier_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/materiel_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/mobilier_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/objet_remplace_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/trajet_binding.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/add_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/detail_materiel.dart';
import 'package:wm_solution/src/pages/logistique/components/materiels/update_materiel.dart';
import 'package:wm_solution/src/pages/logistique/view/materiel_page.dart';
import 'package:wm_solution/src/pages/logistique/view/materiel_roulant_page.dart';
import 'package:wm_solution/src/pages/mailling/bindings/mail_binding.dart';
import 'package:wm_solution/src/pages/marketing/bindings/agenda_binding.dart';
import 'package:wm_solution/src/pages/marketing/bindings/annuaire_binding.dart';
import 'package:wm_solution/src/pages/marketing/bindings/campaign_binding.dart';
import 'package:wm_solution/src/pages/marketing/bindings/dashboard_marketing_binding.dart';
import 'package:wm_solution/src/pages/marketing/components/agenda/detail_agenda.dart';
import 'package:wm_solution/src/pages/marketing/components/agenda/update_agenda.dart';
import 'package:wm_solution/src/pages/marketing/components/annuaire/add_annuaire.dart';
import 'package:wm_solution/src/pages/marketing/components/annuaire/detail_anniuaire.dart';
import 'package:wm_solution/src/pages/marketing/components/annuaire/update_annuaire.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/add_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/detail_campaign.dart';
import 'package:wm_solution/src/pages/marketing/components/campaigns/update_campaign.dart';
import 'package:wm_solution/src/pages/commercial/view/comm_dd.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/achat_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/bon_livraison_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/cart_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/facture_creance_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/facture_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/history_livraison_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/history_ravitaillement_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/produit_model_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/restitution_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/stock_global_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/succursale_page.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/vente_page.dart';
import 'package:wm_solution/src/pages/commercial/view/dashboard_comm_page.dart';
import 'package:wm_solution/src/pages/marketing/view/agenda_page.dart';
import 'package:wm_solution/src/pages/marketing/view/annuaire_page.dart';
import 'package:wm_solution/src/pages/marketing/view/campaign_page.dart';
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
import 'package:wm_solution/src/pages/logistique/components/trajets/add_trajet.dart';
import 'package:wm_solution/src/pages/logistique/components/trajets/detail_trajet.dart'; 
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
import 'package:wm_solution/src/pages/logistique/view/dahsboard_log.dart';
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
import 'package:wm_solution/src/pages/marketing/view/marketing_dahsboard.dart';
import 'package:wm_solution/src/pages/marketing/view/marketing_dd.dart';
import 'package:wm_solution/src/pages/personnels_roles/bindinfs/personnels_role_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/dashboard_notify_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/performence_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/performence_note_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/personnel_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/presence_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/salaire_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/transport_rest_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/transport_rest_personnel_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/user_binding.dart';
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
import 'package:wm_solution/src/pages/screens/help_page.dart';
import 'package:wm_solution/src/pages/screens/settings_page.dart';
import 'package:wm_solution/src/pages/taches/bindings/rapport_binding.dart';
import 'package:wm_solution/src/pages/taches/bindings/tache_binding.dart';
import 'package:wm_solution/src/pages/taches/components/add_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_tache.dart';
import 'package:wm_solution/src/pages/taches/view/tache_page.dart';
import 'package:wm_solution/src/pages/update/view/update_page.dart';
import 'package:wm_solution/src/routes/routes.dart';

List<GetPage<dynamic>>? getPages = [
  // UserRoutes
  GetPage(
      name: UserRoutes.login,
      binding: LoginBinding(),
      page: () => const LoginAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.logout,
      binding: LoginBinding(),
      page: () => const LoginAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.profil,
      binding: ProfilBinding(),
      page: () => const ProfileAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.changePassword,
      binding: ChangePasswordBinding(),
      page: () => const ChangePasswordAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.forgotPassword,
      binding: ForgotPaswordBinding(),
      page: () => const ForgotPassword(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Settings
  GetPage(
      name: SettingsRoutes.settings,
      page: () => const SettingsPage(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: SettingsRoutes.helps,
      page: () => const HelpPage(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(seconds: 1)),
  // GetPage(name: SettingsRoutes.pageVerrouillage, page: page),
  // GetPage(name: SettingsRoutes.splash, page: page),

  // Mails
  GetPage(
      name: MailRoutes.mails,
      binding: MailBinding(),
      page: () => const MailPages(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.addMail,
      binding: MailBinding(),
      page: () => const NewMail(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailSend,
      binding: MailBinding(),
      page: () => const MailSend(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailDetail,
      binding: MailBinding(),
      page: () {
        MailColor mailColor = Get.arguments as MailColor;
        return DetailMail(mailColor: mailColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailRepondre,
      binding: MailBinding(),
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return RepondreMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailTransfert,
      binding: MailBinding(),
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return TransfertMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Taches & Rapports
  GetPage(
      name: TacheRoutes.tachePage,
      binding: TacheBinding(),
      page: () => const TachePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.tacheDetail,
      binding: TacheBinding(),
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return DetailTache(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportDetail,
      binding: RapportBinding(),
      page: () {
        RapportModel rapportModel = Get.arguments as RapportModel;
        return DetailRapport(rapportModel: rapportModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportAdd,
      binding: RapportBinding(),
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return AddRapport(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Archives
  GetPage(
      name: ArchiveRoutes.archives,
      binding: ArchiveFolderBinding(),
      page: () => const ArchiveFolderPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archiveTable,
      binding: ArchiveFolderBinding(),
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return ArchiveData(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.addArchives,
      binding: ArchiveFolderBinding(),
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return AddArchive(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivesDetail,
      binding: ArchiveBinding(),
      page: () {
        ArchiveModel archiveModel = Get.arguments as ArchiveModel;
        return DetailArchive(archiveModel: archiveModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivePdf,
      binding: ArchiveBinding(),
      page: () {
        String url = Get.arguments as String;
        return ArchivePdfViewer(url: url);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // RH
  GetPage(
      name: RhRoutes.rhDashboard,
      bindings: [DashboardNotifyBinding()],
      page: () => const DashboardRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhDD,
      bindings: [SalaireBinding(), TransportRestBinding()],
      page: () => const DDRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsPage,
      binding: PersonnelBinding(),
      page: () => const PersonnelsPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsAdd,
      binding: PersonnelBinding(),
      page: () {
        List<AgentModel> personnelList = Get.arguments as List<AgentModel>;
        return AddPersonnel(personnelList: personnelList);
      }),
  GetPage(
      name: RhRoutes.rhPersonnelsDetail,
      binding: PersonnelBinding(),
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return DetailPersonne(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsUpdate,
      binding: PersonnelBinding(),
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return UpdatePersonnel(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiement,
      binding: SalaireBinding(),
      page: () => const SalairesRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementBulletin,
      binding: SalaireBinding(),
      page: () {
        PaiementSalaireModel salaire = Get.arguments as PaiementSalaireModel;
        return BulletinSalaire(salaire: salaire);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementAdd,
      binding: SalaireBinding(),
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return AddSalaire(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhTransportRest,
      binding: TransportRestBinding(),
      page: () => const TransportRestaurationRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhTransportRestDetail,
      bindings: [TransportRestBinding(), TransportRestPersonnelBinding()],
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
      binding: PerformenceBinding(),
      page: () => const PerformenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceDetail,
      binding: PerformenceBinding(),
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return DetailPerformence(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceAddNote,
      binding: PerformenceNoteBinding(),
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return AddPerformenceNote(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPresence,
      binding: PresenceBinding(),
      page: () => const PresenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPresenceDetail,
      bindings: [PresenceBinding(), PerformenceNoteBinding()],
      page: () {
        final PresenceModel presenceModel = Get.arguments as PresenceModel;
        return DetailPresence(presenceModel: presenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhdetailUser,
      binding: UserBinding(),
      page: () {
        final UserModel userModel = Get.arguments as UserModel;
        return DetailUser(user: userModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Budgets
  GetPage(
      name: BudgetRoutes.budgetDashboard,
      bindings: [
        DashboardBudgetBinding(),
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding()
      ],
      page: () => const DashboardBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetDD,
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
      page: () => const DDBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionel,
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
      page: () => const BudgetPrevisionnelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.historiqueBudgetPrevisionel,
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
      page: () => const HistoriqueBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionelDetail,
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
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
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
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
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
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
      bindings: [
        DashboardComptabiliteBinding(),
        BalanceBinding(),
        BalanceRefBinding(),
        BilanBinding(),
        BilanRefBinding(),
        CompteResultatBinding(),
        JournalBinding(),
        JournalLivreBinding()
      ],
      page: () => const DashboardComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteDD,
      bindings: [
        BalanceBinding(),
        BalanceRefBinding(),
        BilanBinding(),
        BilanRefBinding(),
        CompteResultatBinding(),
        JournalBinding(),
        JournalLivreBinding()
      ],
      page: () => const DDComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalance,
      binding: BalanceBinding(),
      page: () => const BalanceComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalanceDetail,
      bindings: [BalanceBinding(), BalanceRefBinding()],
      page: () {
        final BalanceCompteModel balanceCompteModel =
            Get.arguments as BalanceCompteModel;
        return DetailBalance(balanceCompteModel: balanceCompteModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilan,
      binding: BilanBinding(),
      page: () => const BilanComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBilanDetail,
      bindings: [
        BilanBinding(),
        BilanRefBinding(),
      ],
      page: () {
        final BilanModel bilanModel = Get.arguments as BilanModel;
        return DetailBilan(bilanModel: bilanModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultat,
      binding: CompteResultatBinding(),
      page: () => const CompteResultatComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatDetail,
      binding: CompteResultatBinding(),
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return DetailCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatAdd,
      binding: CompteResultatBinding(),
      page: () => const AddCompteResultat(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatUpdate,
      binding: CompteResultatBinding(),
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return UpdateCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteJournalLivre,
      binding: JournalBinding(),
      page: () => const JournalLivreComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteJournalDetail,
      bindings: [JournalBinding(), JournalLivreBinding()],
      page: () {
        final JournalLivreModel journalLivreModel =
            Get.arguments as JournalLivreModel;
        return DetailJournalLivre(journalLivreModel: journalLivreModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivre,
      bindings: [JournalBinding(), JournalLivreBinding()],
      page: () => const GrandLivre(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivreSearch,
      bindings: [JournalBinding(), JournalLivreBinding()],
      page: () {
        final List<JournalModel> search = Get.arguments as List<JournalModel>;
        return SearchGrandLivre(search: search);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // DevisRoutes
  GetPage(
      name: DevisRoutes.devis,
      binding: DevisBinding(),
      page: () => const DevisPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: DevisRoutes.devisDetail,
      bindings: [DevisBinding(), DevisListObjetBinding()],
      page: () {
        final DevisModel devisModel = Get.arguments as DevisModel;
        return DetailDevis(devisModel: devisModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Finances
  GetPage(
      name: FinanceRoutes.financeDashboard,
      bindings: [
        DashboardFinanceBinding(),
        BanqueBinding(),
        BanqueNameBinding(),
        CaisseNameBinding(),
        CaisseBinding(),
        CreanceBinding(),
        CreanceDetteBinding(),
        DetteBinding(),
        FinExterieurBinding(),
        FinExterieurNameBinding(),
      ],
      page: () => const DashboadFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.finDD,
      bindings: [
        CreanceBinding(),
        CreanceDetteBinding(),
        DetteBinding(),
      ],
      page: () => const DDFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.finObservation,
      binding: ObservationNotifyBinding(),
      page: () => const ObservationPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-banque/:id',
      bindings: [
        BanqueNameBinding(),
        BanqueBinding(),
      ],
      page: () {
        final BanqueNameModel banqueNameModel =
            Get.arguments as BanqueNameModel;
        return BanquePage(banqueNameModel: banqueNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsBanqueDetail,
      bindings: [
        BanqueNameBinding(),
        BanqueBinding(),
      ],
      page: () {
        final BanqueModel banqueModel = Get.arguments as BanqueModel;
        return DetailBanque(banqueModel: banqueModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-caisse/:id',
      bindings: [
        CaisseNameBinding(),
        CaisseBinding(),
      ],
      page: () {
        final CaisseNameModel caisseNameModel =
            Get.arguments as CaisseNameModel;
        return CaissePage(caisseNameModel: caisseNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCaisseDetail,
      bindings: [
        CaisseNameBinding(),
        CaisseBinding(),
      ],
      page: () {
        final CaisseModel caisseModel = Get.arguments as CaisseModel;
        return DetailCaisse(caisseModel: caisseModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreances,
      bindings: [CreanceBinding(), CreanceDetteBinding()],
      page: () => const CreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreanceDetail,
      bindings: [CreanceBinding(), CreanceDetteBinding()],
      page: () {
        final CreanceModel creanceModel = Get.arguments as CreanceModel;
        return DetailCreance(creanceModel: creanceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsDettes,
      bindings: [
        CreanceDetteBinding(),
        DetteBinding(),
      ],
      page: () => const DettePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsDetteDetail,
      bindings: [
        CreanceDetteBinding(),
        DetteBinding(),
      ],
      page: () {
        final DetteModel detteModel = Get.arguments as DetteModel;
        return DetailDette(detteModel: detteModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-financement-externe/:id',
      bindings: [
        FinExterieurNameBinding(),
        FinExterieurBinding(),
      ],
      page: () {
        final FinExterieurNameModel finExterieurNameModel =
            Get.arguments as FinExterieurNameModel;
        return FinExterieurPage(finExterieurNameModel: finExterieurNameModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsFinancementExterneDetail,
      bindings: [
        FinExterieurNameBinding(),
        FinExterieurBinding(),
      ],
      page: () {
        final FinanceExterieurModel financeExterieurModel =
            Get.arguments as FinanceExterieurModel;
        return DetailFinExterieur(financeExterieurModel: financeExterieurModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Marketing
  GetPage(
      name: MarketingRoutes.marketingDashboard,
      bindings: [
        DashboardMarketingBinding(),
        AgendaBinding(),
        AnnuaireBinding(),
        CampaignBinding()
      ],
      page: () => const MarketingDahboard(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingDD,
      binding: CampaignBinding(),
      page: () => const MarketingDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaign,
      binding: CampaignBinding(),
      page: () => const CampaignPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignAdd,
      binding: CampaignBinding(),
      page: () => const AddCampaign(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignDetail,
      bindings: [CampaignBinding(), TacheBinding(), RapportBinding()],
      page: () {
        final CampaignModel campaignModel = Get.arguments as CampaignModel;
        return DetailCampaign(campaignModel: campaignModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignUpdate,
      binding: CampaignBinding(),
      page: () {
        final CampaignModel campaignModel = Get.arguments as CampaignModel;
        return UpdateCampaign(campaignModel: campaignModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: MarketingRoutes.marketingAnnuaire,
      binding: AnnuaireBinding(),
      page: () => const AnnuairePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireAdd,
      binding: AnnuaireBinding(),
      page: () => const AddAnnuaire(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireDetail,
      binding: AnnuaireBinding(),
      page: () {
        final AnnuaireColor annuaireColor = Get.arguments as AnnuaireColor;
        return DetailAnnuaire(annuaireColor: annuaireColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireEdit,
      binding: AnnuaireBinding(),
      page: () {
        final AnnuaireModel annuaireModel = Get.arguments as AnnuaireModel;
        return UpdateAnnuaire(annuaireModel: annuaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: MarketingRoutes.marketingAgenda,
      binding: AgendaBinding(),
      page: () => const AgendaPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAgendaDetail,
      binding: AgendaBinding(),
      page: () {
        final AgendaColor agendaColor = Get.arguments as AgendaColor;
        return DetailAgenda(agendaColor: agendaColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAgendaUpdate,
      binding: AgendaBinding(),
      page: () {
        final AgendaColor agendaColor = Get.arguments as AgendaColor;
        return UpdateAgenda(agendaColor: agendaColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Commercial
  GetPage(
      name: ComRoutes.comDashboard,
      bindings: [
        DashboardComBinding(),
        AchatBinding(),
        GainBinding(),
        VenteCartBinding(),
      ],
      page: () => const DashboardCommPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comDD,
      bindings: [SuccursaleBinding(), ProduitModelBinding()],
      page: () => const CommMarketingDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursale,
      binding: SuccursaleBinding(),
      page: () => const SuccursalePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleAdd,
      binding: SuccursaleBinding(),
      page: () => const AddSuccursale(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleDetail,
      binding: SuccursaleBinding(),
      page: () {
        final SuccursaleModel succursaleModel =
            Get.arguments as SuccursaleModel;
        return DetailSuccursale(succursaleModel: succursaleModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleUpdate,
      binding: SuccursaleBinding(),
      page: () {
        final SuccursaleModel succursaleModel =
            Get.arguments as SuccursaleModel;
        return UpdateSuccursale(succursaleModel: succursaleModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comVente,
      binding: VenteCartBinding(),
      page: () => const VentePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobal,
      bindings: [
        StockGlobalBinding(),
        BonLivraisonBinding(),
        RestitutionBinding(),
        RavitaillementBinding(),
        LivraisonBinding()
      ],
      page: () => const StockGlobalPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobalAdd,
      binding: StockGlobalBinding(),
      page: () => const AddStockGlobal(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobalDetail,
      bindings: [
        StockGlobalBinding(),
        BonLivraisonBinding(),
        RestitutionBinding(),
        RavitaillementBinding(),
        LivraisonBinding()
      ],
      page: () {
        final StocksGlobalMOdel stocksGlobalMOdel =
            Get.arguments as StocksGlobalMOdel;
        return DetailStockGlobal(stocksGlobalMOdel: stocksGlobalMOdel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobalLivraisonStock,
      bindings: [
        StockGlobalBinding(),
        BonLivraisonBinding(),
        LivraisonBinding()
      ],
      page: () {
        final StocksGlobalMOdel stocksGlobalMOdel =
            Get.arguments as StocksGlobalMOdel;
        return LivraisonStock(stocksGlobalMOdel: stocksGlobalMOdel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobalRavitaillement,
      bindings: [
        StockGlobalBinding(),
        RavitaillementBinding(),
      ],
      page: () {
        final StocksGlobalMOdel stocksGlobalMOdel =
            Get.arguments as StocksGlobalMOdel;
        return RavitaillementStock(stocksGlobalMOdel: stocksGlobalMOdel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comRestitution,
      bindings: [
        RestitutionBinding(),
        AchatBinding(),
        StockGlobalBinding(),
      ],
      page: () => const RestitutionPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comRestitutionDetail,
      bindings: [
        RestitutionBinding(),
        AchatBinding(),
        StockGlobalBinding(),
      ],
      page: () {
        final RestitutionModel restitutionModel =
            Get.arguments as RestitutionModel;
        return DetailRestitution(restitutionModel: restitutionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comProduitModel,
      binding: ProduitModelBinding(),
      page: () => const ProduitModelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelAdd,
      binding: ProduitModelBinding(),
      page: () => const AjoutProductModel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelDetail,
      binding: ProduitModelBinding(),
      page: () {
        final ProductModel productModel = Get.arguments as ProductModel;
        return DetailProductModel(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelUpdate,
      binding: ProduitModelBinding(),
      page: () {
        final ProductModel productModel = Get.arguments as ProductModel;
        return UpdateProductModele(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comHistoryRavitaillement,
      binding: HistoryRavitaillementBinding(),
      page: () => const HistoryRavitaillementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comHistoryLivraison,
      binding: HistoryLivraisonBinding(),
      page: () => const HistoryLivraisonPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comFacture,
      binding: FactureBinding(),
      page: () => const FacturePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comCreance,
      binding: FactureCreanceBinding(),
      page: () => const FactureCreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comFactureDetail,
      binding: FactureBinding(),
      page: () {
        final FactureCartModel factureCartModel =
            Get.arguments as FactureCartModel;
        return DetailFacture(factureCartModel: factureCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comCreanceDetail,
      binding: FactureCreanceBinding(),
      page: () {
        final CreanceCartModel creanceCartModel =
            Get.arguments as CreanceCartModel;
        return DetailFactureCreance(creanceCartModel: creanceCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comCart,
      bindings: [
        CartBinding(),
        AchatBinding(),
        FactureBinding(),
        FactureCreanceBinding(),
        GainBinding(),
        NumeroFactureBinding(),
        VenteCartBinding()
      ],
      page: () => const CartPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comCartDetail,
      bindings: [
        CartBinding(),
        AchatBinding(),
        FactureBinding(),
        FactureCreanceBinding(),
        GainBinding(),
        NumeroFactureBinding(),
        VenteCartBinding()
      ],
      page: () {
        final CartModel cart = Get.arguments as CartModel;
        return DetailCart(cart: cart);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comBonLivraison,
      bindings: [
        BonLivraisonBinding(),
        AchatBinding(),
        LivraisonBinding(),
      ],
      page: () => const BonLivraisonPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comBonLivraisonDetail,
      bindings: [
        BonLivraisonBinding(),
        AchatBinding(),
        LivraisonBinding(),
      ],
      page: () {
        final BonLivraisonModel bonLivraisonModel =
            Get.arguments as BonLivraisonModel;
        return DetailBonLivraison(bonLivraisonModel: bonLivraisonModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comAchat,
      bindings: [
        AchatBinding(),
        BonLivraisonBinding(),
        VenteCartBinding(),
        SuccursaleBinding()
      ],
      page: () => const AchatPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comAchatDetail,
      bindings: [
        AchatBinding(),
        BonLivraisonBinding(),
        VenteCartBinding(),
        SuccursaleBinding()
      ],
      page: () {
        final AchatModel achatModel = Get.arguments as AchatModel;
        return DetailAchat(achatModel: achatModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Exploitations
  GetPage(
      name: ExploitationRoutes.expDashboard,
      bindings: [
        DashboardExpBinding(),
        FourniseurBinding(),
        ProductionExpBinding(),
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        ProfilBinding(), 
        ProduitModelBinding()
      ],
      page: () => const DashboardExp(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expDD,
      bindings: [
        ProductionExpBinding(),
        ProjetBinding(),
      ],
      page: () => const ExpDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expFournisseur,
      binding: FourniseurBinding(),
      page: () => const FournisseursPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expFournisseurDetail,
      binding: FourniseurBinding(),
      page: () {
        final FournisseurModel fournisseurModel =
            Get.arguments as FournisseurModel;
        return DetailFournisseur(fournisseurModel: fournisseurModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expProd,
      bindings: [
        ProductionExpBinding(),
        FourniseurBinding(),
        AnnuaireBinding(),
        ProfilBinding(), 
        ProduitModelBinding()
      ],
      page: () => const ProductionExpPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProdDetail,
      bindings: [
        ProductionExpBinding(),
        FourniseurBinding(),
        AnnuaireBinding()
      ],
      page: () {
        final ProductionModel productionModel =
            Get.arguments as ProductionModel;
        return DetailProductionExp(productionModel: productionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expProjet,
      bindings: [ 
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        ProfilBinding(),
        ProduitModelBinding()
      ],
      page: () => const ProjetPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetAdd,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        PersonnelsRoleBinding()
      ],
      page: () => const AddProjet(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetDetail,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        PersonnelsRoleBinding()
      ],
      binding: ProjetBinding(),
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return DetailProjet(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetUpdate,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        PersonnelsRoleBinding()
      ],
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return UpdateProjet(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expVersement,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
      ],
      page: () => const VersementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expVersementAdd,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
      ],
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return AddVersement(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expVersementDetail,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
      ],
      page: () {
        final VersementProjetModel versementProjetModel =
            Get.arguments as VersementProjetModel;
        return DetailVersement(versementProjetModel: versementProjetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Logistique
  GetPage(
      name: LogistiqueRoutes.logDashboard,
      bindings: [
        DashboardLogBinding(),
        DevisBinding(),
        EntretienBinding(),
        EtatMaterielBinding(),
        ImmobilierBinding(),
        MaterielBinding(),
        MobilierBinding(),
        TrajetBinding()
      ],
      page: () => const DashboardLog(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logDD,
      bindings: [
        DevisBinding(),
        EntretienBinding(),
        EtatMaterielBinding(),
        ImmobilierBinding(),
        MaterielBinding(),
        MobilierBinding(),
        TrajetBinding()
      ],
      page: () => const LogDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logMateriel,
      binding: MaterielBinding(),
      page: () => const MaterielPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielRoulant,
      binding: MaterielBinding(),
      page: () => const MaterielRoulantPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielAdd,
      bindings: [
        MaterielBinding(),
        AnnuaireBinding(),
      ],
      page: () => const AddMateriel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielDetail,
      binding: MaterielBinding(),
      page: () {
        final MaterielModel materielModel = Get.arguments as MaterielModel;
        return DetailMateriel(materielModel: materielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielUpdate,
      bindings: [
        MaterielBinding(),
        AnnuaireBinding(),
      ],
      page: () {
        final MaterielModel materielModel = Get.arguments as MaterielModel;
        return UpdateMateriel(materielModel: materielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logTrajetAuto,
      bindings: [TrajetBinding(), MaterielBinding()],
      page: () => const TrajetPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddTrajetAuto,
      bindings: [TrajetBinding(), MaterielBinding()],
      page: () {
        final MaterielModel materielModel = Get.arguments as MaterielModel;
        return AddTrajet(materielModel: materielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logTrajetAutoDetail,
      bindings: [TrajetBinding(), MaterielBinding()],
      page: () {
        final TrajetModel trajetModel = Get.arguments as TrajetModel;
        return DetailTrajet(trajetModel: trajetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEntretien,
      bindings: [EntretienBinding(), ObjetRemplaceBinding(), MaterielBinding()],
      page: () => const EntretiensPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  
  GetPage(
      name: LogistiqueRoutes.logEntretienDetail,
      bindings: [EntretienBinding(), ObjetRemplaceBinding(), MaterielBinding()],
      page: () {
        final EntretienModel entretienModel = Get.arguments as EntretienModel;
        return DetailEntretien(entretienModel: entretienModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEtatMateriel,
      binding: EtatMaterielBinding(),
      page: () => const EtatMaterielPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddEtatMateriel,
      bindings: [
        EtatMaterielBinding(),
        MaterielBinding(),
      ],
      page: () => const AddEtatMateriel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEtatMaterielDetail,
      binding: EtatMaterielBinding(),
      page: () {
        final EtatMaterielModel etatMaterielModel =
            Get.arguments as EtatMaterielModel;
        return DetailEtatMateriel(etatMaterielModel: etatMaterielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEtatMaterielUpdate,
      bindings: [
        EtatMaterielBinding(),
        MaterielBinding(),
      ],
      page: () {
        final EtatMaterielModel etatMaterielModel =
            Get.arguments as EtatMaterielModel;
        return UpdateEtatMateriel(etatMaterielModel: etatMaterielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logImmobilierMateriel,
      binding: ImmobilierBinding(),
      page: () => const ImmobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielDetail,
      binding: ImmobilierBinding(),
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return DetailImmobilier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielUpdate,
      binding: ImmobilierBinding(),
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return UpdateImmobimier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logMobilierMateriel,
      binding: MaterielBinding(),
      page: () => const MobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielDetail,
      binding: MaterielBinding(),
      page: () {
        final MobilierModel mobilierModel = Get.arguments as MobilierModel;
        return DetailMobiler(mobilierModel: mobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielUpdate,
      binding: MaterielBinding(),
      page: () {
        final MobilierModel mobilierModel = Get.arguments as MobilierModel;
        return UpdateMobilier(mobilierModel: mobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionnement, 
      bindings: [
        ApprovisionnementBinding(),
        AnnuaireBinding(),
        ApprovisionReceptionBinding()
      ],
      page: () => const ApprovisionnementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionnementDetail,
      bindings: [
        ApprovisionnementBinding(),
        ApprovisionReceptionBinding(),
        AnnuaireBinding(),
      ],
      page: () {
        final ApprovisionnementModel approvisionnementModel =
            Get.arguments as ApprovisionnementModel;
        return DetailApprovisionnement(
            approvisionnementModel: approvisionnementModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionReception,
      bindings: [ApprovisionnementBinding(), ApprovisionReceptionBinding()],
      page: () => const AccuseReceptionPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionReceptionDetail,
      bindings: [ApprovisionnementBinding(), ApprovisionReceptionBinding()],
      page: () {
        final ApprovisionReceptionModel approvisionReceptionModel =
            Get.arguments as ApprovisionReceptionModel;
        return DetailAccuseReception(
            approvisionReceptionModel: approvisionReceptionModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Administration
  GetPage(
      name: AdminRoutes.adminDashboard,
      bindings: [AdminDashboardBinding()],
      page: () => const AdminDashboard(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminBudget,
      bindings: [BudgetPrevisionnelBinding(), LignBudgetaireBinding()],
      page: () => const AdminBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminMarketing,
      binding: CampaignBinding(),
      page: () => const AdminMarketing(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminComm,
      binding: SuccursaleBinding(),
      page: () => const AdminComm(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminExploitation,
      bindings: [ProjetBinding(), ProductionExpBinding()],
      page: () => const AdminExploitation(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminFinance,
      bindings: [DetteBinding(), CreanceBinding(), CreanceDetteBinding()],
      page: () => const AdminFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminLogistique,
      bindings: [MaterielBinding(), ImmobilierBinding(), DevisBinding()],
      page: () => const AdminLogistique(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminRH,
      bindings: [SalaireBinding(), TransportRestBinding()],
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
