// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/rh/presence_personnel_model.dart';
import 'package:http/http.dart' as http;

class PresencePersonnelApi extends GetConnect {
  var client = http.Client();

  Future<List<PresencePersonnelModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(listPresencePersonnelUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<PresencePersonnelModel> data = [];
      for (var u in bodyList) {
        data.add(PresencePersonnelModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<PresencePersonnelModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/rh/presence-personnels/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return PresencePersonnelModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<PresencePersonnelModel> insertData(
      PresencePersonnelModel presenceModel) async {
    Map<String, String> header = headers;

    var data = presenceModel.toJson();
    var body = jsonEncode(data);

    var resp =
        await client.post(addPresencePersonnelUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return PresencePersonnelModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(presenceModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<PresencePersonnelModel> updateData(
      PresencePersonnelModel presenceModel) async {
    Map<String, String> header = headers;

    var data = presenceModel.toJson();
    var body = jsonEncode(data);
    var updateUrl =
        Uri.parse("$mainUrl/rh/presence-personnels/update-presence-personnel/");

    var resp = await client.put(updateUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return PresencePersonnelModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse(
        "$mainUrl/rh/presence-personnels/delete-presence-personnel/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(res.statusCode);
    }
  }
}
