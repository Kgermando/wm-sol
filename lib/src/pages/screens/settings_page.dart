import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wm_solution/src/constants/app_theme.dart';
import 'package:wm_solution/src/constants/responsive.dart';
import 'package:wm_solution/src/helpers/monnaire_storage.dart';
import 'package:wm_solution/src/navigation/drawer/drawer_menu.dart';
import 'package:wm_solution/src/navigation/header/header_bar.dart';
import 'package:wm_solution/src/utils/dropdown.dart';
import 'package:wm_solution/src/utils/info_system.dart';
import 'package:wm_solution/src/utils/monnaie_dropdown.dart';
import 'package:wm_solution/src/widgets/change_theme_button_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final MonnaieStorage monnaieStorage = Get.put(MonnaieStorage());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String title = "Settings";
  String subTitle = InfoSystem().version();

  List<String> langues = Dropdown().langues;
  List<String> deviseList = MonnaieDropDown().devises;

  String? devise;
  String? langue;
  String? formatImprimante;

  @override
  void initState() {
    super.initState();
    setState(() {
      langues.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: headerBar(context, scaffoldKey, title, subTitle),
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.theater_comedy,
                                title: 'Thèmes',
                                options: ChangeThemeButtonWidget()),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.language,
                                title: 'Langues',
                                options: langueWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.monetization_on,
                                title: 'Devise',
                                options: deviseWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.print,
                                title: 'Format imprimante',
                                options: formatImprimanteWidget(context)),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListSettings(
                                icon: Icons.apps_rounded,
                                title: 'Version Plateform',
                                options: getVersionField(context)),
                          ),
                        ),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  Widget langueWidget(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: langues.first,
        isExpanded: true,
        items: langues.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            langue = value;
          });
        });
  }

  Widget deviseWidget(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Devise',
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: devise,
        isExpanded: true,
        items: deviseList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            devise = value;
            monnaieStorage.removeData();
            monnaieStorage.setData(devise);
          });
        });
  }

  Widget formatImprimanteWidget(BuildContext context) {
    List<String> formatList = ["A4", "A5", "A6"];
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelStyle: TextStyle(),
          contentPadding: EdgeInsets.only(left: 5.0),
        ),
        value: formatImprimante,
        isExpanded: true,
        items: formatList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            formatImprimante = value;
          });
        });
  }

  Widget getVersionField(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return TextButton(
      child: Text(InfoSystem().version(), style: headline6),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(InfoSystem().logo(), height: 200, width: 200),
                const SizedBox(height: p20),
                Text(InfoSystem().name()),
              ],
            ),
            content:
                Text('Version: ${InfoSystem().version()} \nDate: 01-12-2022')),
      ),
    );
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings(
      {Key? key,
      required this.icon,
      required this.title,
      required this.options})
      : super(key: key);

  final IconData icon;
  final String title;
  final Widget options;

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    final headline6 = Theme.of(context).textTheme.headline6;
    return ListTile(
      leading: Icon(icon),
      title: Text(title,
          style: Responsive.isDesktop(context) ? headline5 : headline6),
      trailing: SizedBox(width: 100, child: options),
    );
  }
}
