import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:http/http.dart' as http;

class DepensesAPi extends GetConnect {
  var client = http.Client();

  Future<List<PieChartModel>> getChartPieDepMounth() async {
    Map<String, String> header = headers;

    var resp = await client.get(depensesMonthUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<PieChartModel> data = [];
      for (var row in bodyList) {
        data.add(PieChartModel.fromJson(row));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<List<PieChartModel>> getChartPieDepYear() async {
    Map<String, String> header = headers;

    var resp = await client.get(depensesYearUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<PieChartModel> data = [];
      for (var row in bodyList) {
        data.add(PieChartModel.fromJson(row));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }
}
