import 'package:flutter/material.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart'; 

class ChartPieBalance extends StatefulWidget {
  const ChartPieBalance({Key? key, required this.balanceChartPieList}) : super(key: key);
  final List<BalancePieChartModel> balanceChartPieList;

  @override
  State<ChartPieBalance> createState() => _ChartPieBalanceState();
}

class _ChartPieBalanceState extends State<ChartPieBalance> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: Responsive.isDesktop(context) ? 400 : double.infinity,
      width: MediaQuery.maybeOf(context)!.size.width / 1.1,
      child: Card(
        elevation: 10.0,
        child: SfCircularChart(
            enableMultiSelection: true,
            title: ChartTitle(
                text: 'Comptes',
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
            legend: Legend(isVisible: true, isResponsive: true),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              // Render pie chart
              PieSeries<BalancePieChartModel, String>(
                  dataSource: widget.balanceChartPieList,
                  // pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (BalancePieChartModel data, _) => data.comptes,
                  yValueMapper: (BalancePieChartModel data, _) => data.count)
            ],
            palette : const <Color>[
            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 76, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(77, 139, 185, 16),
            Color.fromRGBO(177, 109, 135, 16),
            Color.fromRGBO(24, 119, 125, 16),
            Color.fromRGBO(247, 179, 145, 16),
            Color.fromRGBO(117, 189, 155, 16),
            Color.fromRGBO(77, 169, 185, 16),
            Color.fromRGBO(73, 79, 165, 16),
            Color.fromRGBO(275, 295, 95, 16),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(152, 108, 142, 17),
            Color.fromRGBO(256, 114, 148, 17),
            Color.fromRGBO(258, 177, 149, 17),
            Color.fromRGBO(156, 180, 155, 17),
            Color.fromRGBO(5, 168, 141, 17),
            Color.fromRGBO(73, 76, 162, 17),
            Color.fromARGB(238, 5, 131, 131),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(70, 104, 44, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 5, 1),
            Color.fromRGBO(246, 80, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(100, 230, 250, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromARGB(255, 216, 130, 17),
            Color.fromARGB(255, 132, 138, 45),
            Color.fromARGB(145, 132, 84, 84),

            Color.fromARGB(255, 47, 114, 45),
            Color.fromARGB(255, 136, 46, 72),
            Color.fromARGB(255, 236, 90, 217),
            Color.fromARGB(255, 215, 236, 23),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromARGB(255, 53, 196, 206),
            Color.fromARGB(255, 100, 73, 162),
            Color.fromARGB(255, 255, 128, 96),
            Color.fromARGB(255, 119, 197, 17),
            Color.fromARGB(255, 43, 35, 119),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromARGB(255, 108, 192, 188),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromARGB(255, 181, 255, 96),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromARGB(255, 100, 184, 5),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 85, 84, 136),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 136, 84, 84),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 23, 151, 7),

            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
            Color.fromRGBO(0, 168, 181, 1),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 207, 153, 76),
            Color.fromARGB(255, 84, 136, 84),

            Color.fromARGB(255, 16, 47, 73),
            Color.fromARGB(255, 248, 9, 77),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromARGB(255, 54, 17, 2),
            Color.fromARGB(255, 0, 226, 139),
            Color.fromARGB(255, 145, 0, 181),
            Color.fromRGBO(73, 76, 162, 1),
            Color.fromRGBO(255, 205, 96, 1),
            Color.fromARGB(255, 76, 203, 207),
            Color.fromARGB(255, 218, 133, 23)
          ],
          ),
      ),
    );
  }
}
