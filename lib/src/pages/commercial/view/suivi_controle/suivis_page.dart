import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/pages/commercial/controller/suivi_controle/suivis_controller.dart';
import 'package:wm_solution/src/routes/routes.dart';
import 'package:wm_solution/src/widgets/loading.dart';

class SuivisPage extends StatefulWidget {
  const SuivisPage({super.key});

  @override
  State<SuivisPage> createState() => _SuivisPageState();
}

class _SuivisPageState extends State<SuivisPage> {
  final SuivisController controller = Get.put(SuivisController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Commercials";
  String subTitle = "Suivis";

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        appBar: headerBar(context, scaffoldKey, title, subTitle),
        drawer: const DrawerMenu(),
        body: Row(
          children: [
            Visibility(
                visible: !Responsive.isMobile(context),
                child: const Expanded(flex: 1, child: DrawerMenu())),
            Expanded(
                flex: 5,
                child: controller.obx(
                    onLoading: loadingPage(context),
                    onEmpty: const Text('Aucune donnée'),
                    onError: (error) => loadingError(context, error!),
                    (state) => Container(
                        margin: const EdgeInsets.only(
                            top: p20, right: p20, left: p20, bottom: p8),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: SizedBox(
                          width: sized.width,
                          height: sized.height,
                          child: Card(
                            elevation: 10,
                            child: SfCalendar(
                              view: CalendarView.month,
                              onTap: (calendarTapDetails) {
                                print("date ${calendarTapDetails.date}");
                                Get.toNamed(ComRoutes.comSuivisDetail,
                                    arguments: calendarTapDetails.date);
                              },
                              appointmentBuilder:
                                  (context, calendarAppointmentDetails) {
                                print(
                                    "date2 ${calendarAppointmentDetails.date}");
                                return Container(
                                  color: Colors.red,
                                  width: p20,
                                );
                              },
                            ),
                          ),
                        )))),
          ],
        ));
  }
}
