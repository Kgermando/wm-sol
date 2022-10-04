// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/finances/creances_model.dart';
import 'package:http/http.dart' as http;

class CreanceApi extends GetConnect {
  var client = http.Client();

  Future<List<CreanceModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(creancesUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CreanceModel> data = [];
      for (var u in bodyList) {
        data.add(CreanceModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<CreanceModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/finances/transactions/creances/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return CreanceModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CreanceModel> insertData(CreanceModel creanceModel) async {
    Map<String, String> header = headers;

    var data = creanceModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addCreancesUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return CreanceModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(creanceModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<CreanceModel> updateData(CreanceModel creanceModel) async {
    Map<String, String> header = headers;

    var data = creanceModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/finances/transactions/creances/update-transaction-creance/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return CreanceModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/finances/transactions/creances/delete-transaction-creance/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
