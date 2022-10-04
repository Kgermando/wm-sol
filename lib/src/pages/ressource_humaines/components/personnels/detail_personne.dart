import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/rh/agent_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart'; 

class DetailPersonne extends StatefulWidget {
  const DetailPersonne({super.key, required this.personne});
  final AgentModel personne;

  @override
  State<DetailPersonne> createState() => _DetailPersonneState();
}

class _DetailPersonneState extends State<DetailPersonne> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines";
   
  
  
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, "${widget.personne.prenom} ${widget.personne.nom}"),
      drawer: const DrawerMenu(),
      body: Row(
        children: [
          Visibility(
            visible: !Responsive.isMobile(context),
            child: const Expanded(flex: 1, child: DrawerMenu())),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const ScrollPhysics(),
              child: Container(
                 margin: const EdgeInsets.only(
                      top: p20, bottom: p8, right: p20, left: p20),
                  decoration: const BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(p20),
                    child: Column(
                      children: [
                        
                      ]
                    ),
                  ),
                )),
            )
          )  
        ],
      ),
    );
  }
}