// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/charts/chart_finance.dart';
import 'package:wm_solution/src/models/charts/courbe_chart_model.dart';
import 'package:wm_solution/src/models/finances/banque_model.dart';
import 'package:http/http.dart' as http;

class BanqueApi extends GetConnect {
  var client = http.Client();

  Future<List<BanqueModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(banqueUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BanqueModel> data = [];
      for (var u in bodyList) {
        data.add(BanqueModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<BanqueModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/finances/transactions/banques/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return BanqueModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<BanqueModel> insertData(BanqueModel banqueModel) async {
   Map<String, String> header = headers;

    var data = banqueModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addBanqueUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return BanqueModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(banqueModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<BanqueModel> updateData(BanqueModel banqueModel) async {
    Map<String, String> header = headers;

    var data = banqueModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques/update-transaction-banque/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return BanqueModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/finances/transactions/banques/delete-transaction-banque/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<List<ChartFinanceModel>> getAllDataChart() async {
    Map<String, String> header = headers;

    var resp = await client.get(banqueChartUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<ChartFinanceModel> data = [];
      for (var u in bodyList) {
        data.add(ChartFinanceModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  
}
