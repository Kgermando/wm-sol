// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/rh/perfomence_model.dart';
import 'package:http/http.dart' as http;

class PerformenceApi extends GetConnect {
  var client = http.Client();

  Future<List<PerformenceModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(listPerformenceUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<PerformenceModel> data = [];
      for (var u in bodyList) {
        data.add(PerformenceModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<PerformenceModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/rh/performences/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return PerformenceModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<PerformenceModel> insertData(PerformenceModel performenceModel) async {
    Map<String, String> header = headers;

    var data = performenceModel.toJson();
    var body = jsonEncode(data);

    var resp =
        await client.post(addPerformenceUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return PerformenceModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(performenceModel);
    } else {
      throw Exception(resp.statusCode);
    }
  }

  Future<PerformenceModel> updateData(
      PerformenceModel performenceModel) async {
    Map<String, String> header = headers;

    var data = performenceModel.toJson();
    var body = jsonEncode(data);
    var updateUrl =
        Uri.parse("$mainUrl/rh/performences/update-performence/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return PerformenceModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl =
        Uri.parse("$mainUrl/rh/performences/delete-performence/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(res.statusCode);
    }
  }
}
