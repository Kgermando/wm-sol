import 'package:get/get.dart';
import 'package:wm_solution/src/bindings/network_bindings.dart';
import 'package:wm_solution/src/bindings/wm_binding.dart';
import 'package:wm_solution/src/models/actionnaire/actionnaire_model.dart';
import 'package:wm_solution/src/models/archive/archive_model.dart';
import 'package:wm_solution/src/models/budgets/departement_budget_model.dart';
import 'package:wm_solution/src/models/budgets/ligne_budgetaire_model.dart';
import 'package:wm_solution/src/models/commercial/achat_model.dart';
import 'package:wm_solution/src/models/commercial/bon_livraison.dart';
import 'package:wm_solution/src/models/commercial/cart_model.dart';
import 'package:wm_solution/src/models/commercial/creance_cart_model.dart';
import 'package:wm_solution/src/models/commercial/facture_cart_model.dart';
import 'package:wm_solution/src/models/commercial/prod_model.dart';
import 'package:wm_solution/src/models/commercial/restitution_model.dart';
import 'package:wm_solution/src/models/commercial/stocks_global_model.dart';
import 'package:wm_solution/src/models/commercial/succursale_model.dart';
import 'package:wm_solution/src/models/commercial/vente_cart_model.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:wm_solution/src/models/comptabilites/bilan_model.dart';
import 'package:wm_solution/src/models/comptabilites/compte_resultat_model.dart';
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
import 'package:wm_solution/src/models/marketing/agenda_model.dart';
import 'package:wm_solution/src/models/marketing/annuaire_model.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/models/suivi_controle/abonnement_client_model.dart';
import 'package:wm_solution/src/models/suivi_controle/entreprise_info_model.dart';
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
import 'package:wm_solution/src/models/update/update_model.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/pages/404/error.dart';
import 'package:wm_solution/src/pages/actionnaire/binding/actionnaire_binding.dart';
import 'package:wm_solution/src/pages/actionnaire/components/detail_actionnaire.dart';
import 'package:wm_solution/src/pages/actionnaire/view/actionnaire_cotisation_page.dart';
import 'package:wm_solution/src/pages/actionnaire/view/actionnaire_dashboard.dart';
import 'package:wm_solution/src/pages/actionnaire/view/actionnaire_page.dart';
import 'package:wm_solution/src/pages/actionnaire/view/actionnaire_transfert_page.dart';
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
import 'package:wm_solution/src/pages/archives/components/archive_image_reader.dart';
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
import 'package:wm_solution/src/pages/commercial/bindings/suivi_controle/abonnement_client_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/suivi_controle/entreprise_infos_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/suivi_controle/suivis_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/achat_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/bon_livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/cart_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/dashboard_com_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/facture_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/facture_creance_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/gain_cart_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/history_livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/history_ravitaillement_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/livraison_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/numero_facture_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/produit_model_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/ravitaillement_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/restitution_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/stock_global_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/succursale_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/vente_cart_binding.dart';
import 'package:wm_solution/src/pages/commercial/bindings/ventes/vente_effectue_binding.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/achats/detail_achat.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/bon_livraison/detail_bon_livraison.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/cart/detail_cart.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/detail_facture.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/factures/detail_facture_creance.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/produit_model/ajout_product_model.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/produit_model/detail_product_model.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/produit_model/update_product_modele_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/restitution/detail_restitution.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/stock_global/add_stock_global.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/stock_global/detail_stock_global.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/stock_global/livraison_stock.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/stock_global/ravitaillement_stock.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/succursale/add_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/succursale/detail_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/succursale/update_succursale.dart';
import 'package:wm_solution/src/pages/commercial/components/commercial/vente_effectue/detail_vente_effectue.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/abonnement_client/add_abonnement_client.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/abonnement_client/detail_abonnement_client.dart'; 
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/entreprise_infos/add_entreprise_infos.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/entreprise_infos/detail_entreprise_infos.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/entreprise_infos/update_entreprise_infos.dart';
import 'package:wm_solution/src/pages/commercial/components/suivi_controle/suivis/detail_suivis.dart';
import 'package:wm_solution/src/pages/commercial/view/commercials/vente_effectue_page.dart'; 
import 'package:wm_solution/src/pages/commercial/view/suivi_controle/abonnement_client_page.dart';
import 'package:wm_solution/src/pages/commercial/view/suivi_controle/entreprise_infos_page.dart';
import 'package:wm_solution/src/pages/commercial/view/suivi_controle/suivis_page.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/balance_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/bilan_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/bilan_ref_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/compte_resultat_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/dashboard_comptabilite_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/bindings/journal_binding.dart';
import 'package:wm_solution/src/pages/comptabilites/view/grand_livre.dart';
import 'package:wm_solution/src/pages/logistique/bindings/devis_binding.dart';
import 'package:wm_solution/src/pages/logistique/bindings/devis_list_objet_binding.dart';
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
import 'package:wm_solution/src/pages/comptabilites/components/bilan/detail_bilan.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/add_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/detail_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/compte_resultat/update_compte_resultat.dart';
import 'package:wm_solution/src/pages/comptabilites/components/grand_livre/search_grand_livre.dart';
import 'package:wm_solution/src/pages/comptabilites/view/balance_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/bilan_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/compte_resultat_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/dashboard_comptabilite.dart';
import 'package:wm_solution/src/pages/comptabilites/view/dd_comptabilie.dart';
import 'package:wm_solution/src/pages/comptabilites/view/journal_comptabilite.dart';
import 'package:wm_solution/src/pages/logistique/components/devis/detail_devis.dart';
import 'package:wm_solution/src/pages/logistique/view/devis_page.dart';
import 'package:wm_solution/src/pages/exploitations/components/fournisseurs/detail_fournisseur.dart';
import 'package:wm_solution/src/pages/exploitations/components/productions/detail_production_exp.dart';
import 'package:wm_solution/src/pages/exploitations/components/projets/detail_projet.dart';
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
import 'package:wm_solution/src/pages/marketing/view/dashboard_marketing_page.dart';
import 'package:wm_solution/src/pages/marketing/view/marketing_dd.dart';
import 'package:wm_solution/src/pages/personnels_roles/bindings/personnels_role_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/dashboard_notify_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/performence_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/performence_note_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/personnel_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/presence_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/presence_personne_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/salaire_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/transport_rest_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/transport_rest_personnel_binding.dart';
import 'package:wm_solution/src/pages/ressource_humaines/bindings/users_binding.dart';
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
import 'package:wm_solution/src/pages/ressource_humaines/view/users_actif_page.dart';
import 'package:wm_solution/src/pages/screens/help_page.dart';
import 'package:wm_solution/src/pages/screens/settings_page.dart';
import 'package:wm_solution/src/pages/screens/splash_page.dart';
import 'package:wm_solution/src/pages/taches/bindings/rapport_binding.dart';
import 'package:wm_solution/src/pages/taches/bindings/tache_binding.dart';
import 'package:wm_solution/src/pages/taches/components/add_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_rapport.dart';
import 'package:wm_solution/src/pages/taches/components/detail_tache.dart';
import 'package:wm_solution/src/pages/taches/view/tache_page.dart';
import 'package:wm_solution/src/pages/update/components/detail_update.dart';
import 'package:wm_solution/src/pages/update/view/update_page.dart';
import 'package:wm_solution/src/routes/routes.dart';

List<GetPage<dynamic>>? getPages = [
  // 404
  GetPage(
      name: ExceptionRoutes.notFound,
      page: () => const PageNotFound(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Settings
  GetPage(
      name: SettingsRoutes.splash,
      bindings: [WMBindings(), NetworkBindings()],
      page: () => const SplashView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // UserRoutes
  GetPage(
      name: UserRoutes.login,
      bindings: [LoginBinding(), NetworkBindings()],
      page: () => const LoginAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.logout,
      bindings: [LoginBinding(), NetworkBindings()],
      page: () => const LoginAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.profil,
      bindings: [ProfilBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const ProfileAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.changePassword,
      bindings: [ChangePasswordBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const ChangePasswordAuth(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UserRoutes.forgotPassword,
      bindings: [ForgotPaswordBinding(), ProfilBinding(), NetworkBindings()],
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
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const MailPages(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.addMail,
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const NewMail(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailSend,
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const MailSend(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailDetail,
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        MailColor mailColor = Get.arguments as MailColor;
        return DetailMail(mailColor: mailColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailRepondre,
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return RepondreMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MailRoutes.mailTransfert,
      bindings: [
        MailBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        MailModel mailModel = Get.arguments as MailModel;
        return TransfertMail(mailModel: mailModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Taches & Rapports
  GetPage(
      name: TacheRoutes.tachePage,
      bindings: [TacheBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const TachePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.tacheDetail,
      bindings: [TacheBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return DetailTache(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportDetail,
      bindings: [
        RapportBinding(),
        TacheBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        RapportModel rapportModel = Get.arguments as RapportModel;
        return DetailRapport(rapportModel: rapportModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: TacheRoutes.rapportAdd,
      binding: RapportBinding(),
      bindings: [
        RapportBinding(),
        TacheBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        TacheModel tacheModel = Get.arguments as TacheModel;
        return AddRapport(tacheModel: tacheModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Archives
  GetPage(
      name: ArchiveRoutes.archivesFolder,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const ArchiveFolderPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archiveTable,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return ArchiveData(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.addArchives,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        ArchiveFolderModel archiveFolderModel =
            Get.arguments as ArchiveFolderModel;
        return AddArchive(archiveFolderModel: archiveFolderModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivesDetail,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        ArchiveModel archiveModel = Get.arguments as ArchiveModel;
        return DetailArchive(archiveModel: archiveModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archivePdf,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        String url = Get.arguments as String;
        return ArchivePdfViewer(url: url);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ArchiveRoutes.archiveImage,
      bindings: [
        ArchiveBinding(),
        ArchiveFolderBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        String url = Get.arguments as String;
        return ArchiveImageReader(url: url);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // RH
  GetPage(
      name: RhRoutes.rhDashboard,
      bindings: [
        DashboardNotifyBinding(),
        PersonnelBinding(),
        SalaireBinding(),
        TransportRestBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhDD,
      bindings: [
        SalaireBinding(),
        TransportRestBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DDRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsPage,
      bindings: [
        PersonnelBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const PersonnelsPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsAdd,
      bindings: [
        PersonnelBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        List<AgentModel> personnelList = Get.arguments as List<AgentModel>;
        return AddPersonnel(personnelList: personnelList);
      }),
  GetPage(
      name: RhRoutes.rhPersonnelsDetail,
      bindings: [
        PersonnelBinding(),
        PerformenceBinding(),
        PerformenceNoteBinding(),
        UsersBinding(),
        PresenceBinding(),
        PrersencePersonneBinding(),
        ActionnaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return DetailPersonne(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPersonnelsUpdate,
      bindings: [
        PersonnelBinding(),
        UsersBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        AgentModel personne = Get.arguments as AgentModel;
        return UpdatePersonnel(personne: personne);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhPaiement,
      bindings: [SalaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const SalairesRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementBulletin,
      bindings: [SalaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        PaiementSalaireModel salaire = Get.arguments as PaiementSalaireModel;
        return BulletinSalaire(salaire: salaire);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPaiementAdd,
      bindings: [SalaireBinding(), ProfilBinding(), NetworkBindings()],
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
      bindings: [
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
      bindings: [
        PerformenceBinding(),
        PerformenceNoteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const PerformenceRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceDetail,
      bindings: [
        PerformenceBinding(),
        PerformenceNoteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        PerformenceModel performenceModel = Get.arguments as PerformenceModel;
        return DetailPerformence(performenceModel: performenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhPerformenceAddNote,
      bindings: [
        PerformenceBinding(),
        PerformenceNoteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
      bindings: [
        PresenceBinding(),
        PrersencePersonneBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final PresenceModel presenceModel = Get.arguments as PresenceModel;
        return DetailPresence(presenceModel: presenceModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: RhRoutes.rhdetailUser,
      bindings: [
        UsersBinding(),
        PersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final UserModel userModel = Get.arguments as UserModel;
        return DetailUser(user: userModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: RhRoutes.rhUserActif,
      bindings: [
        UsersBinding(),
        PersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const UsersActifPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Budgets
  GetPage(
      name: BudgetRoutes.budgetDashboard,
      bindings: [
        DashboardBudgetBinding(),
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetDD,
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DDBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionel,
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const BudgetPrevisionnelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.historiqueBudgetPrevisionel,
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const HistoriqueBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: BudgetRoutes.budgetBudgetPrevisionelDetail,
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        BilanBinding(),
        BilanRefBinding(),
        CompteResultatBinding(),
        JournalBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteDD,
      bindings: [
        BalanceBinding(),
        BilanBinding(),
        BilanRefBinding(),
        CompteResultatBinding(),
        JournalBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DDComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteBalance,
      bindings: [BalanceBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const BalanceComptabilite(),
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
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final BilanModel bilanModel = Get.arguments as BilanModel;
        return DetailBilan(bilanModel: bilanModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultat,
      bindings: [CompteResultatBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const CompteResultatComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatDetail,
      bindings: [CompteResultatBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return DetailCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatAdd,
      bindings: [CompteResultatBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AddCompteResultat(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteCompteResultatUpdate,
      binding: CompteResultatBinding(),
      bindings: [CompteResultatBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final CompteResulatsModel compteResulatsModel =
            Get.arguments as CompteResulatsModel;
        return UpdateCompteResultat(compteResulatsModel: compteResulatsModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteJournalLivre,
      bindings: [
        JournalBinding(),
        BalanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const JournalLivreComptabilite(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivre,
      bindings: [
        JournalBinding(),
        BalanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const GrandLivre(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComptabiliteRoutes.comptabiliteGrandLivreSearch,
      bindings: [
        JournalBinding(),
        BalanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final List<BalanceModel> search = Get.arguments as List<BalanceModel>;
        return SearchGrandLivre(search: search);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // DevisRoutes
  GetPage(
      name: DevisRoutes.devis,
      bindings: [DevisBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const DevisPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: DevisRoutes.devisDetail,
      bindings: [
        DevisBinding(),
        DevisListObjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DDFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.finObservation,
      bindings: [
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const ObservationPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: '/transactions-banque/:id',
      bindings: [
        BanqueNameBinding(),
        BanqueBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final CaisseModel caisseModel = Get.arguments as CaisseModel;
        return DetailCaisse(caisseModel: caisseModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreances,
      bindings: [
        CreanceBinding(),
        CreanceDetteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const CreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsCreanceDetail,
      bindings: [
        CreanceBinding(),
        CreanceDetteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DettePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: FinanceRoutes.transactionsDetteDetail,
      bindings: [
        CreanceDetteBinding(),
        DetteBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        CampaignBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardMarketingPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingDD,
      bindings: [CampaignBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const MarketingDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaign,
      bindings: [CampaignBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const CampaignPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignAdd,
      bindings: [CampaignBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AddCampaign(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignDetail,
      bindings: [
        CampaignBinding(),
        TacheBinding(),
        RapportBinding(),
        PersonnelsRoleBinding(),
        PersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final CampaignModel campaignModel = Get.arguments as CampaignModel;
        return DetailCampaign(campaignModel: campaignModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingCampaignUpdate,
      bindings: [
        CampaignBinding(),
        PersonnelsRoleBinding(),
        PersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final CampaignModel campaignModel = Get.arguments as CampaignModel;
        return UpdateCampaign(campaignModel: campaignModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: MarketingRoutes.marketingAnnuaire,
      bindings: [AnnuaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AnnuairePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireAdd,
      bindings: [AnnuaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AddAnnuaire(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireDetail,
      bindings: [AnnuaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final AnnuaireColor annuaireColor = Get.arguments as AnnuaireColor;
        return DetailAnnuaire(annuaireColor: annuaireColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAnnuaireEdit,
      bindings: [AnnuaireBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final AnnuaireModel annuaireModel = Get.arguments as AnnuaireModel;
        return UpdateAnnuaire(annuaireModel: annuaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: MarketingRoutes.marketingAgenda,
      bindings: [AgendaBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AgendaPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAgendaDetail,
      bindings: [AgendaBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final AgendaColor agendaColor = Get.arguments as AgendaColor;
        return DetailAgenda(agendaColor: agendaColor);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: MarketingRoutes.marketingAgendaUpdate,
      bindings: [AgendaBinding(), ProfilBinding(), NetworkBindings()],
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
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        SuccursaleBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardCommPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comDD,
      bindings: [
        SuccursaleBinding(),
        AchatBinding(),
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const CommMarketingDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursale,
      bindings: [
        SuccursaleBinding(),
        AchatBinding(),
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const SuccursalePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleAdd,
      bindings: [
        SuccursaleBinding(),
        AchatBinding(),
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AddSuccursale(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleDetail,
      bindings: [
        SuccursaleBinding(),
        AchatBinding(),
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final SuccursaleModel succursaleModel =
            Get.arguments as SuccursaleModel;
        return DetailSuccursale(succursaleModel: succursaleModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuccursaleUpdate,
      bindings: [
        SuccursaleBinding(),
        AchatBinding(),
        GainCartBinding(),
        VenteCartBinding(),
        FactureCreanceBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final SuccursaleModel succursaleModel =
            Get.arguments as SuccursaleModel;
        return UpdateSuccursale(succursaleModel: succursaleModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comVente,
      bindings: [
        VenteCartBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        LivraisonBinding(),
        HistoryRavitaillementBinding(),
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const StockGlobalPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comStockGlobalAdd,
      bindings: [
        StockGlobalBinding(),
        ProduitModelBinding(),
        HistoryRavitaillementBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        LivraisonBinding(),
        ProduitModelBinding(),
        HistoryRavitaillementBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        LivraisonBinding(),
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProduitModelBinding(),
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
      bindings: [ProduitModelBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const ProduitModelPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelAdd,
      bindings: [ProduitModelBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AjoutProductModel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelDetail,
      bindings: [ProduitModelBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final ProductModel productModel = Get.arguments as ProductModel;
        return DetailProductModel(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comProduitModelUpdate,
      bindings: [ProduitModelBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final ProductModel productModel = Get.arguments as ProductModel;
        return UpdateProductModele(productModel: productModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comHistoryRavitaillement,
      bindings: [
        HistoryRavitaillementBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const HistoryRavitaillementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comHistoryLivraison,
      bindings: [
        HistoryLivraisonBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const HistoryLivraisonPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comFacture,
      bindings: [
        FactureBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const FacturePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comCreance,
      bindings: [
        FactureCreanceBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const FactureCreancePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comFactureDetail,
      bindings: [
        FactureBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final FactureCartModel factureCartModel =
            Get.arguments as FactureCartModel;
        return DetailFacture(factureCartModel: factureCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comCreanceDetail,
      bindings: [
        FactureCreanceBinding(),
        CartBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        GainCartBinding(),
        NumeroFactureBinding(),
        VenteCartBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        GainCartBinding(),
        NumeroFactureBinding(),
        VenteCartBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        SuccursaleBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        SuccursaleBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final AchatModel achatModel = Get.arguments as AchatModel;
        return DetailAchat(achatModel: achatModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comVenteEffectue,
      binding: VenteEffectueBinding(),
      page: () => const VenteEffectue(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comVenteEffectueDetail,
      binding: VenteEffectueBinding(),
      page: () {
        final VenteCartModel venteCartModel = Get.arguments as VenteCartModel;
        return DetailVenteEffectue(venteCartModel: venteCartModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ComRoutes.comEntreprise,
      binding: EnntrepriseInfosBinding(),
      page: () => const EntrepriseInfoPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comEntrepriseAdd,
      binding: EnntrepriseInfosBinding(),
      page: () => const AddEntrepriseInfos(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
    name: ComRoutes.comEntrepriseDetail,
    binding: EnntrepriseInfosBinding(),
    page: () {
      final EntrepriseInfoModel entrepriseInfoModel = Get.arguments as EntrepriseInfoModel;
      return DetailEntrepriseInfos(entrepriseInfoModel: entrepriseInfoModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),
  GetPage(
    name: ComRoutes.comEntrepriseUpdate,
    binding: EnntrepriseInfosBinding(),
    page: () {
      final EntrepriseInfoModel entrepriseInfoModel =
          Get.arguments as EntrepriseInfoModel;
      return UpdateEntrperiseInfos(entrepriseInfoModel: entrepriseInfoModel);
    },
    transition: Transition.cupertino,
    transitionDuration: const Duration(seconds: 1)
  ),


  GetPage(
      name: ComRoutes.comAbonnements,
      binding: AbonnementClientBinding(),
      page: () => const AbonnementClientPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comAbonnementAdd,
      binding: AbonnementClientBinding(),
      page: () {
        final EntrepriseInfoModel entrepriseInfoModel =
            Get.arguments as EntrepriseInfoModel;
        return AddAbonnementClient(entrepriseInfoModel: entrepriseInfoModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comAbonnementDetail,
      binding: AbonnementClientBinding(),
      page: () {
        final AbonnementClientModel abonnementClientModel =
            Get.arguments as AbonnementClientModel;
        return DetailAbonnementClient(
            abonnementClientModel: abonnementClientModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)), 

  GetPage(
      name: ComRoutes.comSuivis,
      binding: SuivisBinding(),
      page: () => const SuivisPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ComRoutes.comSuivisDetail,
      binding: SuivisBinding(),
      page: () {
        final DateTime dateTime = Get.arguments as DateTime;
        return DetailSuivis(dateTime: dateTime);
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
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const DashboardExp(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expDD,
      bindings: [
        ProductionExpBinding(),
        ProduitModelBinding(),
        ProjetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const ExpDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expFournisseur,
      bindings: [FourniseurBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const FournisseursPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expFournisseurDetail,
      bindings: [FourniseurBinding(), ProfilBinding(), NetworkBindings()],
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
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const ProductionExpPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProdDetail,
      bindings: [
        ProductionExpBinding(),
        FourniseurBinding(),
        AnnuaireBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProduitModelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const ProjetPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  // GetPage(
  //     name: ExploitationRoutes.expProjetAdd,
  //     bindings: [
  //       ProjetBinding(),
  //       VersementBinding(),
  //       TacheBinding(),
  //       RapportBinding(),
  //       PersonnelsRoleBinding(),
  //       PersonnelBinding(),
  //       ProfilBinding(), NetworkBindings()
  //     ],
  //     page: () => const AddProjet(),
  //     transition: Transition.cupertino,
  //     transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expProjetDetail,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        TacheBinding(),
        RapportBinding(),
        PersonnelsRoleBinding(),
        PersonnelBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      binding: ProjetBinding(),
      page: () {
        final ProjetModel projetModel = Get.arguments as ProjetModel;
        return DetailProjet(projetModel: projetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  // GetPage(
  //     name: ExploitationRoutes.expProjetUpdate,
  //     bindings: [
  //       ProjetBinding(),
  //       VersementBinding(),
  //       TacheBinding(),
  //       RapportBinding(),
  //       PersonnelsRoleBinding(),
  //       PersonnelBinding(),
  //       ProfilBinding(), NetworkBindings()
  //     ],
  //     page: () {
  //       final ProjetModel projetModel = Get.arguments as ProjetModel;
  //       return UpdateProjet(projetModel: projetModel);
  //     },
  //     transition: Transition.cupertino,
  //     transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: ExploitationRoutes.expVersement,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const VersementPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ExploitationRoutes.expVersementAdd,
      bindings: [
        ProjetBinding(),
        VersementBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        NetworkBindings()
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
        TrajetBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        TrajetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const LogDD(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logMateriel,
      binding: MaterielBinding(),
      bindings: [
        MaterielBinding(),
        TrajetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const MaterielPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielRoulant,
      bindings: [
        MaterielBinding(),
        TrajetBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const MaterielRoulantPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielAdd,
      bindings: [
        MaterielBinding(),
        TrajetBinding(),
        AnnuaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AddMateriel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMaterielDetail,
      bindings: [
        MaterielBinding(),
        TrajetBinding(),
        AnnuaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        TrajetBinding(),
        AnnuaireBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final MaterielModel materielModel = Get.arguments as MaterielModel;
        return UpdateMateriel(materielModel: materielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logTrajetAuto,
      bindings: [
        TrajetBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const TrajetPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddTrajetAuto,
      bindings: [
        TrajetBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final MaterielModel materielModel = Get.arguments as MaterielModel;
        return AddTrajet(materielModel: materielModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logTrajetAutoDetail,
      bindings: [
        TrajetBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final TrajetModel trajetModel = Get.arguments as TrajetModel;
        return DetailTrajet(trajetModel: trajetModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEntretien,
      bindings: [
        EntretienBinding(),
        ObjetRemplaceBinding(),
        MaterielBinding(),
        ImmobilierBinding(),
        MobilierBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const EntretiensPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEntretienDetail,
      bindings: [
        EntretienBinding(),
        ObjetRemplaceBinding(),
        ImmobilierBinding(),
        MobilierBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final EntretienModel entretienModel = Get.arguments as EntretienModel;
        return DetailEntretien(entretienModel: entretienModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logEtatMateriel,
      binding: EtatMaterielBinding(),
      bindings: [EtatMaterielBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const EtatMaterielPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logAddEtatMateriel,
      bindings: [
        EtatMaterielBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AddEtatMateriel(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logEtatMaterielDetail,
      bindings: [
        EtatMaterielBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
        ProfilBinding(),
        NetworkBindings()
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
      bindings: [ImmobilierBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const ImmobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielDetail,
      bindings: [ImmobilierBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return DetailImmobilier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logImmobilierMaterielUpdate,
      bindings: [ImmobilierBinding(), ProfilBinding(), NetworkBindings()],
      page: () {
        final ImmobilierModel immobilierModel =
            Get.arguments as ImmobilierModel;
        return UpdateImmobimier(immobilierModel: immobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  GetPage(
      name: LogistiqueRoutes.logMobilierMateriel,
      bindings: [
        MobilierBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const MobilierPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielDetail,
      bindings: [
        MobilierBinding(),
        MaterielBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () {
        final MobilierModel mobilierModel = Get.arguments as MobilierModel;
        return DetailMobiler(mobilierModel: mobilierModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logMobilierMaterielUpdate,
      bindings: [MaterielBinding(), ProfilBinding(), NetworkBindings()],
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
        ApprovisionReceptionBinding(),
        ProfilBinding(),
        NetworkBindings()
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
        ProfilBinding(),
        ProfilBinding(),
        NetworkBindings()
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
      bindings: [
        ApprovisionnementBinding(),
        ApprovisionReceptionBinding(),
        ProfilBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AccuseReceptionPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: LogistiqueRoutes.logApprovisionReceptionDetail,
      bindings: [
        ApprovisionnementBinding(),
        ApprovisionReceptionBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
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
      bindings: [
        AdminDashboardBinding(),
        ProfilBinding(),
        NetworkBindings(),
        PersonnelBinding(),
        BanqueBinding(),
        CaisseBinding(),
        CreanceBinding(),
        CreanceDetteBinding(),
        DetteBinding(),
        FinExterieurBinding(),
        SalaireBinding(),
        CampaignBinding(),
        DevisBinding(),
        DevisListObjetBinding(),
        TransportRestBinding(),
        TransportRestPersonnelBinding(),
        ProjetBinding(),
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        DashboardComptabiliteBinding(),
        BalanceBinding(),
        BilanBinding(),
        BilanRefBinding(),
        CompteResultatBinding(),
        JournalBinding(),
        DashboardComBinding(),
        VenteCartBinding(),
        GainCartBinding(),
        FactureBinding(),
        FactureCreanceBinding(),
        SuccursaleBinding(),
      ],
      page: () => const AdminDashboard(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminBudget,
      bindings: [
        BudgetPrevisionnelBinding(),
        LignBudgetaireBinding(),
        CampaignBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AdminBudget(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminMarketing,
      bindings: [CampaignBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AdminMarketing(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminComm,
      bindings: [SuccursaleBinding(), ProfilBinding(), NetworkBindings()],
      page: () => const AdminComm(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminExploitation,
      bindings: [
        ProjetBinding(),
        ProduitModelBinding(),
        ProductionExpBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AdminExploitation(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminFinance,
      bindings: [
        DetteBinding(),
        CreanceBinding(),
        CreanceDetteBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AdminFinance(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminLogistique,
      bindings: [
        MaterielBinding(),
        ImmobilierBinding(),
        DevisBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AdminLogistique(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: AdminRoutes.adminRH,
      bindings: [
        SalaireBinding(),
        TransportRestBinding(),
        ProfilBinding(),
        NetworkBindings()
      ],
      page: () => const AdminRH(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Actionnaire
  GetPage(
      name: ActionnaireRoute.actionnaireDashboard,
      binding: ActionnaireBinding(),
      page: () => const ActionnaireDashboard(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ActionnaireRoute.actionnairePage,
      binding: ActionnaireBinding(),
      page: () => const ActionnairePage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ActionnaireRoute.actionnaireDetail,
      binding: ActionnaireBinding(),
      page: () {
        final ActionnaireModel actionnaireModel =
            Get.arguments as ActionnaireModel;
        return DetailActionnaire(actionnaireModel: actionnaireModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ActionnaireRoute.actionnaireCotisation,
      binding: ActionnaireBinding(),
      page: () => const ActionnaireCotisationPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: ActionnaireRoute.actionnaireTransfert,
      binding: ActionnaireBinding(),
      page: () => const ActionnaireTransfertPage(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),

  // Update version
  GetPage(
      name: UpdateRoutes.updatePage,
      page: () => const UpdatePage(),
      bindings: [ProfilBinding(), NetworkBindings()],
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
  GetPage(
      name: UpdateRoutes.updateDetail,
      bindings: [ProfilBinding(), NetworkBindings()],
      page: () {
        final UpdateModel updateModel = Get.arguments as UpdateModel;
        return DetailUpdate(updateModel: updateModel);
      },
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1)),
];
