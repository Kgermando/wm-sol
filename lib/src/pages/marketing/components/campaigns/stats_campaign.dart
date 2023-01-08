import 'package:flutter/material.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/models/marketing/campaign_model.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/marketing/controller/campaigns/compaign_controller.dart';
import 'package:wm_solution/src/pages/personnels_roles/controller/personnels_roles_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/personnels_controller.dart';
import 'package:wm_solution/src/pages/taches/controller/taches_controller.dart';


class StatsCampaign extends StatefulWidget {
  const StatsCampaign(
      {super.key,
      required this.campaignModel,
      required this.monnaieStorage,
      required this.controller,
      required this.profilController,
      required this.personnelsRolesController,
      required this.personnelsController,
      required this.tachesController
      });
  final CampaignModel campaignModel;
  final MonnaieStorage monnaieStorage;
  final CampaignController controller;
  final ProfilController profilController;
  final PersonnelsRolesController personnelsRolesController;
  final PersonnelsController personnelsController;
  final TachesController tachesController;


  @override
  State<StatsCampaign> createState() => _StatsCampaignState();
}

class _StatsCampaignState extends State<StatsCampaign> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}