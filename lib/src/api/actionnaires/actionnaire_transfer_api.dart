// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart'; 
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/actionnaire/actionnaire_transfert_model.dart';

class ActionnaireTransfertApi extends GetConnect {
  var client = http.Client();

  Future<List<ActionnaireTransfertModel>> getAllData() async {
    Map<String, String> header = headers;

    var res = await client.get(actionnaireTransferttUrl, headers: header);

    if (res.statusCode == 200) {
      List<dynamic> bodyList = json.decode(res.body);
      List<ActionnaireTransfertModel> data = [];
      for (var u in bodyList) {
        data.add(ActionnaireTransfertModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<ActionnaireTransfertModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/admin/actionnaire-transferts/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return ActionnaireTransfertModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<ActionnaireTransfertModel> insertData(
      ActionnaireTransfertModel actionnaireTransfertModel) async {
    Map<String, String> header = headers;

    var data = actionnaireTransfertModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(actionnaireTransfertAddUrl,
        headers: header, body: body);
    if (resp.statusCode == 200) {
      return ActionnaireTransfertModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(actionnaireTransfertModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<ActionnaireTransfertModel> updateData(
      ActionnaireTransfertModel actionnaireTransfertModel) async {
    Map<String, String> header = headers;

    var data = actionnaireTransfertModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/admin/actionnaire-transferts/update-actionnaire-tranfert/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return ActionnaireTransfertModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/admin/actionnaire-transferts/delete-actionnaire-tranfert/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(res.statusCode);
    }
  }
}
