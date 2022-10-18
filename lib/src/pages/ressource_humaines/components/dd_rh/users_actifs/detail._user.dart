import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import 'package:wm_solution/src/constants/responsive.dart'; 
import 'package:flutter/material.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial_marketing/controller/commercials/succursale/succursale_controller.dart';
import 'package:wm_solution/src/pages/ressource_humaines/controller/personnels/user_actif_controller.dart'; 
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart'; 

class DetailUser extends StatefulWidget {
  const DetailUser({super.key, required this.user});
  final UserModel user;

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Ressources Humaines"; 

  @override
  Widget build(BuildContext context) {
    final UsersController controller = Get.put(UsersController());
    final SuccursaleController succursaleController = Get.put(SuccursaleController());
    final bodyMedium = Theme.of(context).textTheme.bodyMedium; 
    // List<dynamic> depList = jsonDecode(widget.user.departement);
    // print("depList $depList");
    return controller.obx(
    onLoading: loading(),
    onEmpty: const Text('Aucune donnée'),
    onError: (error) => Text(
        "Une erreur s'est produite $error veiller actualiser votre logiciel. Merçi."),
    (state) => Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title,
              "${widget.user.prenom} ${widget.user.nom}"),
          drawer: const DrawerMenu(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: p20, vertical: p20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveChildWidget(
                                        child1: Text('Nom :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium!.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.nom,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)), 
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Prénom :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.prenom,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Email :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.email,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Téléphone :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.telephone,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)), 
                                            Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text(
                                            'Niveau d\'accréditation :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.role,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Matricule :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.matricule,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Date de création :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: Text(
                                            DateFormat("dd-MM-yyyy").format(
                                                widget.user
                                                    .createdAt),
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text('Département :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user.departement,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)),
                                    Divider(color: mainColor),
                                    ResponsiveChildWidget(
                                        child1: Text(
                                            'Services d\'affectation :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: SelectableText(
                                            widget.user
                                                .servicesAffectation,
                                            textAlign: TextAlign.start,
                                            style: bodyMedium)), 
                                    Divider(color: mainColor),
                                    const SizedBox(height:p20),
                                    ResponsiveChildWidget(
                                        child1: Text(
                                            'Succursale :',
                                            textAlign: TextAlign.start,
                                            style: bodyMedium.copyWith(
                                                fontWeight:
                                                    FontWeight.bold)),
                                        child2: succursaleWidget(controller, succursaleController)
                                    ),
                                    
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }


  Widget succursaleWidget(UsersController controller, SuccursaleController succursaleController) {
    var succList = succursaleController.succursaleList.map((e) => e.name).toList();
    
    return Container(
      margin: const EdgeInsets.only(bottom: p20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Succursale',
          labelStyle: const TextStyle(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          contentPadding: const EdgeInsets.only(left: 5.0),
        ),
        value: controller.succursale,
        isExpanded: true,
        items: succList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) => value == null ? "Select Succursale" : null,
        onChanged: (value) {
          setState(() {
            controller.succursale = value!;
            controller.succursaleUser(widget.user);
          });
        },
      ),
    );
  }
}
