
class SettingsRoutes {
  static const helps = "/helps";
  static const settings = "/settings";
  static const splash = "/splash";
  static const pageVerrouillage = "/page-verrouillage";
}

class UpdateRoutes {
  static const updatePage = "/update-page";
  static const updateAdd = "/update-add";
}

class TacheRoutes {
  static const tachePage = "/tache-page";  
  static const tacheDetail = "/tache-detail";
  static const rapportAdd = "/rapport-add"; 
  static const rapportDetail = "/rapport-detail";
} 

class UserRoutes {
  static const login = "/";
  static const logout = "/login";
  static const profil = "/profil"; 
  static const forgotPassword = "/forgot-password";
  static const changePassword = "/change-password";
 
}

class DevisRoutes {
  static const devis = "/devis";
  static const devisAdd = "/devis-add";
  static const devisDetail = "/devis-detail";
}

class ActionnaireRoute {
  static const actionnaireDashboard = "/actionnaire-dashboard";
  static const actionnairePage = "/actionnaire-page";
  static const actionnaireDetail = "/actionnaire-detail";
}

class AdminRoutes { 
  static const adminDashboard = "/admin-dashboard";
  static const adminRH = "/admin-rh";
  static const adminBudget = "/admin-budget";
  static const adminComptabilite = "/admin-comptabilite";
  static const adminFinance = "/admin-finances";
  static const adminExploitation = "/admin-exploitations";
  static const adminCommMarketing = "/admin-commercial-marketing";
  static const adminLogistique = "/admin-logistiques";
}

class RhRoutes { 
  static const rhDashboard = "/rh-dashboard"; 
  static const rhPersonnelsPage = "/rh-personnels-page";  
  static const rhPersonnelsAdd = "/rh-personnelss-add";
  static const rhPersonnelsDetail = "/rh-personnelss-detail";
  static const rhPersonnelsUpdate = "/rh-personnelss-update";
  static const rhdetailUser = "/rh-detail-user";  
  static const rhPersonnelsPageUser = "/rh-personnelss-page-user";
  static const rhPaiement = "/rh-paiements";
  static const rhPaiementAdd = "/rh-paiements-add";
  static const rhPaiementBulletin = "/rh-paiements-bulletin";
  static const rhPresence = "/rh-presences";
  static const rhPresenceDetail = "/rh-presences-detail";
  static const rhPresencePersonnels = "/rh-presence-Personnels";
  static const rhPerformence = "/rh-performence";
  static const rhPerformenceDetail = "/rh-performence-detail";
  static const rhPerformenceAddNote = "/rh-performence-add-note";
  static const rhPerformenceAdd = "/rh-performence-add";
  static const rhDD = "/rh-dd";
  static const rhHistoriqueSalaire = "/rh-historique-salaire";
  static const rhTransportRest = "/rh-transport-rest";
  static const rhTransportRestDetail = "/rh-transport-rest-detail";
  static const rhTablePersonnelsActifs = "/rh-table-Personnels-actifs";
  static const rhTablePersonnelsInactifs = "/rh-table-Personnels-inactifs";
  static const rhTablePersonnelsFemme = "/rh-table-Personnels-femme";
  static const rhTablePersonnelsHomme = "/rh-table-Personnels-homme";
}

class BudgetRoutes {
  static const budgetDashboard = "/budget-dashboard";
  static const budgetDD = "/budget-dd";
  static const budgetBudgetPrevisionel = "/budgets-previsionels";
  static const budgetBudgetPrevisionelAdd = "/budgets-previsionels-add";
  static const budgetLignebudgetaireDetail = "/budgets-ligne-budgetaire-detail";
  static const budgetLignebudgetaireAdd = "/budgets-ligne-budgetaire-add";
  static const historiqueBudgetPrevisionel =
      "/historique-budgets-previsionels";
  static const budgetBudgetPrevisionelDetail = "/budgets-previsionels-detail";
}

class FinanceRoutes {
  static const financeDashboard = "/finance-dashboard";
  static const financeTransactions = "/finance-transactions";
  static const transactionsCaisse = "/transactions-caisse";
  static const transactionsCaisseDetail = "/transactions-caisse-detail";
  static const transactionsCaisseEncaissement =
      "/transactions-caisse-encaissement";
  static const transactionsCaisseDecaissement =
      "/transactions-caisse-decaissement";
  static const transactionsBanque = "/transactions-banque";
  static const transactionsBanqueDetail = "/transactions-banque-detail";
  static const transactionsBanqueRetrait = "/transactions-banque-retrait";
  static const transactionsBanqueDepot = "/transactions-banque-depot";
  static const transactionsDettes = "/transactions-dettes";
  static const transactionsDetteDetail = "/transactions-dettes-detail";
  static const transactionsCreances = "/transactions-creances";
  static const transactionsCreanceDetail = "/transactions-creances-detail";
  static const transactionsFinancementExterne =
      "/transactions-financement-externe";
  static const transactionsFinancementExterneAdd =
      "/transactions-financement-externe-add";
  static const transactionsFinancementExterneDetail =
      "/transactions-financement-externe-detail";

  // static const transactionsDepenses = "/transactions-depenses";
  static const finDD = "/fin-dd";
  static const finObservation = "/fin-observation";
}

class ComptabiliteRoutes {
  static const comptabiliteDashboard = "/comptabilite-dashboard";
  static const comptabiliteBilan = "/comptabilite-bilan";
  static const comptabiliteBilanAdd = "/comptabilite-bilan-add";
  static const comptabiliteBilanDetail = "/comptabilite-bilan-detail";
  static const comptabiliteJournalLivre = "/comptabilite-journal-livre";
  static const comptabiliteJournalDetail = "/comptabilite-journal-detail";
  static const comptabiliteJournalAdd = "/comptabilite-journal-add";
  static const comptabiliteCompteResultat = "/comptabilite-compte-resultat";
  static const comptabiliteCompteResultatAdd =
      "/comptabilite-compte-resultat-add";
  static const comptabiliteCompteResultatDetail =
      "/comptabilite-compte-resultat-detail";
  static const comptabiliteCompteResultatUpdate =
      "/comptabilite-compte-resultat-update";
  static const comptabiliteBalance = "/comptabilite-balance";
  static const comptabiliteBalanceAdd = "/comptabilite-balance-add";
  static const comptabiliteBalanceDetail = "/comptabilite-balance-detail";
  static const comptabiliteGrandLivre = "/comptabilite-grand-livre";
  static const comptabiliteGrandLivreSearch =
      "/comptabilite-grand-livre-search";
  static const comptabiliteDD = "/comptabilite-dd";
  static const comptabiliteCorbeille = "/comptabilite-corbeille";
}

class LogistiqueRoutes {
  static const logDashboard = "/log-dashboard";
  static const logAnguinAuto = "/log-anguin-auto";
  static const logAnguinAutoDetail = "/log-anguin-auto-detail";
  static const logAnguinAutoUpdate = "/log-anguin-auto-update";
  static const logAddAnguinAuto = "/log-add-anguin-auto";
  static const logAddCarburantAuto = "/log-add-carburant-auto";
  static const logCarburantAuto = "/log-carburant-auto";
  static const logCarburantAutoDetail = "/log-carburant-auto-detail";
  static const logAddTrajetAuto = "/log-add-trajet-auto";
  static const logTrajetAuto = "/log-trajet-auto";
  static const logTrajetAutoDetail = "/log-trajet-auto-detail";
  static const logTrajetAutoUpdate = "/log-trajet-auto-update";
  static const logAddEntretien = "/log-add-entretien";
  static const logEntretien = "/log-entretien";
  static const logEntretienDetail = "/log-entretien-detail";
  static const logEntretienUpdate = "/log-entretien-update";
  static const logAddEtatMateriel = "/log-add-etat-materiel";
  static const logEtatMateriel = "/log-etat-materiel";
  static const logEtatMaterielDetail = "/log-etat-materiel-detail";
  static const logEtatMaterielUpdate = "/log-etat-materiel-update";
  static const logAddImmobilerMateriel = "/log-add-immobilier-materiel";
  static const logImmobilierMateriel = "/log-immobilier-materiel";
  static const logImmobilierMaterielDetail = "/log-immobilier-materiel-detail";
  static const logImmobilierMaterielUpdate = "/log-immobilier-materiel-update";
  static const logAddMobilierMateriel = "/log-add-mobilier-materiel";
  static const logMobilierMateriel = "/log-mobilier-materiel";
  static const logMobilierMaterielDetail = "/log-mobilier-materiel-detail";
  static const logMobilierMaterielUpdate = "/log-mobilier-materiel-udpate";
  static const logDD = "/log-dd";
  static const logEtatBesoin = "/log-etat-besoin";
  static const logApprovisionnement = "/log-approvisionnement"; 
  static const logApprovisionnementDetail = "/log-approvisionnement-detail"; 
  static const logApprovisionReception = "/log-approvision-reception";
  static const logApprovisionReceptionDetail = "/log-approvision-reception-detail";
}

class ExploitationRoutes {
  static const expDashboard = "/exploitation-dashboard";
  static const expProjetAdd = "/exploitation-projets-add";
  static const expProjet = "/exploitation-projets";
  static const expProjetUpdate = "/exploitation-projet-update";
  static const expProjetDetail = "/exploitation-projets-detail";
  static const expProd = "/exploitation-productions";
  static const expProdDetail = "/exploitation-productions-detail";
  static const expFournisseur = "/exploitation-fournisseurs";
  static const expFournisseurDetail = "/exploitation-fournisseurs-detail"; 
  static const expVersement = "/exploitation-virement";
  static const expVersementAdd = "/exploitation-virement-add";
  static const expVersementDetail = "/exploitation-virement-detail";
  static const expDD = "/exp-dd";
}

class ComMarketingRoutes {
  static const comMarketingDD = "/com-marketing-dd";
  static const comMarketingDashboard = "/com-marketing-dashboard";
  // Marketing
  static const comMarketingAnnuaire = "/com-marketing-annuaire";
  static const comMarketingAnnuaireAdd = "/com-marketing-annuaire-add";
  static const comMarketingAnnuaireDetail = "/com-marketing-annuaire-detail";
  static const comMarketingAnnuaireEdit = "/com-marketing-annuaire-edit";
  static const comMarketingAgenda = "/com-marketing-agenda";
  static const comMarketingAgendaAdd = "/com-marketing-agenda-add";
  static const comMarketingAgendaDetail = "/com-marketing-agenda-detail";
  static const comMarketingAgendaUpdate = "/com-marketing-agenda-update";
  static const comMarketingCampaign = "/com-marketing-campaign";
  static const comMarketingCampaignAdd = "/com-marketing-campaign-add";
  static const comMarketingCampaignDetail = "/com-marketing-campaign-detail";
  static const comMarketingCampaignUpdate = "/com-marketing-campaign-update";

  // Commercial
  static const comMarketingProduitModel = "/com-marketing-produit-model";
  static const comMarketingProduitModelDetail =
      "/com-marketing-produit-model-detail";
  static const comMarketingProduitModelAdd = "/com-marketing-produit-model-add";
  static const comMarketingProduitModelUpdate =
      "/com-marketing-produit-model-update";
  static const comMarketingStockGlobal = "/com-marketing-stock-global";
  static const comMarketingStockGlobalDetail =
      "/com-marketing-stock-global-detail";
  static const comMarketingStockGlobalAdd = "/com-marketing-stock-global-add";
  static const comMarketingStockGlobalRavitaillement =
      "/com-marketing-stock-global-ravitaillement";
  static const comMarketingStockGlobalLivraisonStock =
      "/com-marketing-stock-global-livraisonStock";
  static const comMarketingSuccursale = "/com-marketing-succursale";
  static const comMarketingSuccursaleDetail =
      "/com-marketing-succursale-detail";
  static const comMarketingSuccursaleAdd = "/com-marketing-succursale-add";
  static const comMarketingSuccursaleUpdate =
      "/com-marketing-succursale-update";
  static const comMarketingAchat = "/com-marketing-achat";
  static const comMarketingAchatDetail = "/com-marketing-achat-detail";
  static const comMarketingBonLivraison = "/com-marketing-bon-livraison";
  static const comMarketingBonLivraisonDetail =
      "/com-marketing-bon-livraison-detail";
  static const comMarketingcart = "/com-marketing-cart";
  static const comMarketingcartDetail = "/com-marketing-cart-detail";
  static const comMarketingCreance = "/com-marketing-creance";
  static const comMarketingCreanceDetail = "/com-marketing-creance-detail";
  static const comMarketingFacture = "/com-marketing-facture";
  static const comMarketingFactureDetail = "/com-marketing-facture-detail";
  static const comMarketingGain = "/com-marketing-gain";
  static const comMarketingHistoryRavitaillement =
      "/com-marketing-history-ravitaillement";
  static const comMarketingHistoryLivraison =
      "/com-marketing-history-livraison";
  static const comMarketingnumberFact = "/com-marketing-number-fact";
  static const comMarketingRestitutionStock =
      "/com-marketing-restitution-stock";
  static const comMarketingRestitution = "/com-marketing-restitution";
  static const comMarketingRestitutionDetail =
      "/com-marketing-restitution-detail";
  static const comMarketingVente = "/com-marketing-vente";
}

class ArchiveRoutes {
  static const archives = "/archives";
  static const archiveTable = "/archives-table";
  static const addArchives = "/archives-add";
  static const archivesDetail = "/archives-detail";
  static const archivePdf = "/archives-pdf";
}

class MailRoutes {
  static const mails = "/mails";
  static const mailSend = "/mail-send";
  static const addMail = "/mail-add";
  static const mailDetail = "/mail-detail";
  static const mailRepondre = "/mail-repondre";
  static const mailTransfert = "/mail-tranfert";
}


