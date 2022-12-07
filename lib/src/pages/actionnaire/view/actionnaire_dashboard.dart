import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/actionnaire/components/dashbaord/chart_bar_action.dart';
import 'package:wm_solution/src/pages/actionnaire/components/dashbaord/chart_pie_action.dart';
import 'package:wm_solution/src/pages/actionnaire/components/dashbaord/table_dashboard_action.dart';
import 'package:wm_solution/src/pages/actionnaire/controller/actionnaire_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/dash_number_widget.dart';
import 'package:wm_solution/src/widgets/loading.dart';
import 'package:wm_solution/src/widgets/responsive_child_widget.dart';

class ActionnaireDashboard extends StatefulWidget {
  const ActionnaireDashboard({super.key});

  @override
  State<ActionnaireDashboard> createState() => _ActionnaireDashboardState();
}

class _ActionnaireDashboardState extends State<ActionnaireDashboard> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final ActionnaireController controller = Get.put(ActionnaireController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Actionnaire";
  String subTitle = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          appBar: headerBar(context, scaffoldKey, title, subTitle),
          drawer: const DrawerMenu(),
          body: controller.obx(
              onLoading: loadingPage(context),
              onEmpty: const Text('Aucune donnée'),
              onError: (error) => loadingError(context, error!), (state) {
            double totalCotisations = 0.0;
            int femme = 0;
            int homme = 0;

            for (var element in state!) {
              totalCotisations += element.cotisations;
            }
            femme = state.where((element) => element.sexe == "Femme").length;
            homme = state.where((element) => element.sexe == "Homme").length;

            return Row(
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
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: p20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ActionnaireRoute
                                                .actionnairePage);
                                          },
                                          number:
                                              NumberFormat.decimalPattern('fr')
                                                  .format(state.length),
                                          title: 'Actionnaires',
                                          icon: Icons.group,
                                          color: Colors.blue.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ActionnaireRoute
                                                .actionnairePage);
                                          },
                                          number:
                                              '${NumberFormat.decimalPattern('fr').format(totalCotisations)} ${monnaieStorage.monney}',
                                          title: 'Total',
                                          icon: Icons.monetization_on,
                                          color: Colors.green.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ActionnaireRoute
                                                .actionnairePage);
                                          },
                                          number:
                                              NumberFormat.decimalPattern('fr')
                                                  .format(femme),
                                          title: 'Femme',
                                          icon: Icons.female,
                                          color: Colors.red.shade700),
                                      DashNumberWidget(
                                          gestureTapCallback: () {
                                            Get.toNamed(ActionnaireRoute
                                                .actionnairePage);
                                          },
                                          number:
                                              NumberFormat.decimalPattern('fr')
                                                  .format(homme),
                                          title: 'Homme',
                                          icon: Icons.male,
                                          color: Colors.brown.shade700),
                                    ],
                                  ), 
                                  const SizedBox(height: p20),
                                  ResponsiveChildWidget(
                                    mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      child1: ChartBarActions(state: state),
                                      child2: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ChartPieAction(state: state),
                                          const SizedBox(height: p20),
                                          TableDahboardAction(
                                              state: controller
                                                  .actionnaireLimitList)
                                        ],
                                      )),
                                ]),
                          )),
                    ))
              ],
            );
          })),
    );
  }
}
