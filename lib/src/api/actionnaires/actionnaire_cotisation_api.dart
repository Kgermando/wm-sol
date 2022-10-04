// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/administrations/actionnaire_cotisation_model.dart';
import 'package:http/http.dart' as http;

class ActionnaireCotisationApi extends GetConnect {
  var client = http.Client();

  Future<List<ActionnaireCotisationModel>> getAllData() async {
    Map<String, String> header = headers;

    var res = await client.get(actionnaireCotisationListUrl, headers: header);

    if (res.statusCode == 200) {
      List<dynamic> bodyList = json.decode(res.body);
      List<ActionnaireCotisationModel> data = [];
      for (var u in bodyList) {
        data.add(ActionnaireCotisationModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<ActionnaireCotisationModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/admin/actionnaire-cotisations/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return ActionnaireCotisationModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<ActionnaireCotisationModel> insertData(
      ActionnaireCotisationModel actionnaireCotisationModel) async {
    Map<String, String> header = headers;

    var data = actionnaireCotisationModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(actionnaireCotisationAddUrl,
        headers: header, body: body);
    if (resp.statusCode == 200) {
      return ActionnaireCotisationModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(actionnaireCotisationModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<ActionnaireCotisationModel> updateData(
      ActionnaireCotisationModel actionnaireCotisationModel) async {
    Map<String, String> header = headers;

    var data = actionnaireCotisationModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse(
        "$mainUrl/admin/actionnaire-cotisations/update-actionnaire-cotisation/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return ActionnaireCotisationModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/admin/actionnaire-cotisations/delete-actionnaire-cotisation/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(res.statusCode);
    }
  }
}
