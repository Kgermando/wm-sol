// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/comptabilites/balance_model.dart';
import 'package:http/http.dart' as http; 

class BalanceApi extends GetConnect {
  var client = http.Client();

  Future<List<BalanceSumModel>> getAllSumData() async {
    Map<String, String> header = headers;

    var resp = await client.get(balanceSumUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BalanceSumModel> data = [];
      for (var u in bodyList) {
        data.add(BalanceSumModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<List<BalanceChartModel>> getAllChartData() async {
    Map<String, String> header = headers;

    var resp = await client.get(balanceChartUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BalanceChartModel> data = [];
      for (var u in bodyList) {
        data.add(BalanceChartModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<List<BalancePieChartModel>> getAllChartPieData() async {
    Map<String, String> header = headers;

    var resp = await client.get(balanceChartPieUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BalancePieChartModel> data = [];
      for (var u in bodyList) {
        data.add(BalancePieChartModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }


  Future<List<BalanceModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(balanceCompteUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<BalanceModel> data = [];
      for (var u in bodyList) {
        data.add(BalanceModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<BalanceModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/comptabilite/balances/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return BalanceModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<BalanceModel> insertData(
      BalanceModel balanceCompteModel) async {
    Map<String, String> header = headers;

    var data = balanceCompteModel.toJson();
    var body = jsonEncode(data);

    var resp =
        await client.post(addBalanceUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return BalanceModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(balanceCompteModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<BalanceModel> updateData(
      BalanceModel balanceCompteModel) async {
    Map<String, String> header = headers;

    var data = balanceCompteModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/comptabilite/balances/update-balance/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return BalanceModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/comptabilite/balances/delete-balance/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
