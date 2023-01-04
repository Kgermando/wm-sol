import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/models/marketing/annuaire_model.dart'; 
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/marketing/components/annuaire/annuaire_xlsx.dart';
import 'package:wm_solution/src/pages/marketing/controller/annuaire/annuaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/utils/list_colors.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/print_widget.dart';
import 'package:wm_solution/src/widgets/search_widget.dart';
import 'package:wm_solution/src/widgets/title_widget.dart';

// final _lightColors = [
//   Colors.pinkAccent.shade700,
//   Colors.tealAccent.shade700,
//   Colors.lightGreen.shade700,
//   Colors.lightBlue.shade700,
//   Colors.orange.shade700,
// ];

class AnnuairePage extends StatefulWidget {
  const AnnuairePage({super.key});

  @override
  State<AnnuairePage> createState() => _AnnuairePageState();
}

class _AnnuairePageState extends State<AnnuairePage> {
  final AnnuaireController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Marketing";
  String subTitle = "Annuaire";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
      drawer: const DrawerMenu(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ajouter contact"),
        tooltip: "Ajout un nouveau contact",
        icon: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(MarketingRoutes.marketingAnnuaireAdd);
        },
      ),
      body: controller.obx(
          onLoading: loadingPage(context),
          onEmpty: const Text('Aucune donnée'),
          onError: (error) => loadingError(context, error!),
          (state) => Row(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TitleWidget(title: "Annuaire"),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.getList();
                                            },
                                            icon: Icon(Icons.refresh,
                                                color: Colors.green.shade700)),
                                        PrintWidget(onPressed: () {
                                          AnnuaireXlsx().exportToExcel(
                                              controller.annuaireList);
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                "Exportation effectué!"),
                                            backgroundColor: Colors.green[700],
                                          ));
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                                buildSearch(controller),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.annuaireList.length,
                                    itemBuilder: (context, index) {
                                      final annuaireModel =
                                          controller.annuaireList[index];
                                      return buildAnnuaire(
                                          annuaireModel, index);
                                    }),
                              ],
                            ),
                          )))
                ],
              )),
    );
  }

  Widget buildSearch(AnnuaireController controller) => SearchWidget(
        text: controller.query,
        hintText: 'Recherche rapide',
        onChanged: (String value) {
          searchAchat(controller, value);
        },
      );

  Future searchAchat(AnnuaireController controller, String query) async =>
      controller.debounce(() {
        if (!mounted) return;
        setState(() {
          query = query;
          controller.annuaireList;
        });
      });

  Widget buildAnnuaire(AnnuaireModel annuaireModel, int index) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    final color = listColors[index % listColors.length];
    return Card(
      child: ListTile(
        onTap: () {
          Get.toNamed(MarketingRoutes.marketingAnnuaireDetail,
              arguments:
                  AnnuaireColor(annuaireModel: annuaireModel, color: color));
        },
        leading: Icon(Icons.perm_contact_cal_sharp, color: color, size: 50),
        title: Text(
          annuaireModel.nomPostnomPrenom,
          style: bodyText1,
        ),
        subtitle: Text(
          annuaireModel.mobile1,
          style: bodyText2,
        ),
        trailing: Text(
          annuaireModel.categorie,
          style: bodyText2,
        ),
      ),
    );
  }
}
