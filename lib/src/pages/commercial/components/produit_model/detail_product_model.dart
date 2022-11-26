import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/comm_maketing/prod_model.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/auth/controller/profil_controller.dart';
import 'package:wm_solution/src/pages/commercial/components/produit_model/approbation_prod_model.dart';
import 'package:wm_solution/src/pages/commercial/controller/commercials/produit_model/produit_model_controller.dart';
import 'package:wm_solution/src/routes/routes.dart'; 
import 'package:wm_solution/src/widgets/title_widget.dart';

class DetailProductModel extends StatefulWidget {
  const DetailProductModel({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<DetailProductModel> createState() => _DetailProductModelState();
}

class _DetailProductModelState extends State<DetailProductModel> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercial";

  @override
  Widget build(BuildContext context) {
    final ProduitModelController controller = Get.find();
    final ProfilController profilController = Get.find();

    return Scaffold(
              key: scaffoldKey,
              appBar: headerBar(
                  context, scaffoldKey, title, widget.productModel.idProduct),
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
                                        horizontal: p20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleWidget(
                                                title: widget
                                                    .productModel.categorie),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    if (widget.productModel
                                                            .approbationDD ==
                                                        "-")
                                                      editButton(controller),
                                                    if (widget.productModel
                                                            .approbationDD ==
                                                        "-")
                                                      deleteButton(controller),
                                                  ],
                                                ),
                                                SelectableText(
                                                    DateFormat(
                                                            "dd-MM-yyyy HH:mm")
                                                        .format(widget
                                                            .productModel
                                                            .created),
                                                    textAlign: TextAlign.start),
                                              ],
                                            )
                                          ],
                                        ),
                                        dataWidget()
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: p20),
                                ApprobationProdModel(
                                    data: widget.productModel,
                                    controller: controller,
                                    profilController: profilController)
                              ],
                            ),
                          )))
                ],
              ),
            );
  }

  Widget editButton(ProduitModelController controller) {
    return IconButton(
      icon: Icon(Icons.edit, color: Colors.purple.shade700),
      tooltip: "Modification",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de modifier ceci?',
              style: TextStyle(color: mainColor)),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed(ComRoutes.comProduitModelUpdate,
                    arguments: widget.productModel);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteButton(ProduitModelController controller) {
    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red.shade700),
      tooltip: "Supprimer",
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Etes-vous sûr de modifier ceci?',
              style: TextStyle(color: mainColor)),
          content:
              const Text('Cette action permet de supprimer définitivement.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                controller.produitModelApi.deleteData(widget.productModel.id!);
                Navigator.pop(context, 'ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataWidget() {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(p10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Identifiant Produit :',
                    textAlign: TextAlign.start,
                    style: bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.idProduct,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Categorie Produit :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.categorie,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Sous Categorie 1:',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.sousCategorie1,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Sous Categorie 2:',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.sousCategorie2,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Sous Categorie 3:',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.sousCategorie3,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Unité:',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.sousCategorie4,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
          Row(
            children: [
              Expanded(
                child: Text('Signature :',
                    textAlign: TextAlign.start,
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: SelectableText(widget.productModel.signature,
                    textAlign: TextAlign.start, style: bodyMedium),
              )
            ],
          ),
          Divider(color: mainColor),
        ],
      ),
    );
  }
}
