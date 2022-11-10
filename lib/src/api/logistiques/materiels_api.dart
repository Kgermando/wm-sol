// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart'; 
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/charts/pie_chart_model.dart';
import 'package:wm_solution/src/models/logistiques/material_model.dart';

class MaterielsApi extends GetConnect {
  var client = http.Client();

  Future<List<MaterielModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(anguinsUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<MaterielModel> data = [];
      for (var u in bodyList) {
        data.add(MaterielModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<MaterielModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/materiels/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return MaterielModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<MaterielModel> insertData(MaterielModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(aaddAnguinsUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return MaterielModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(dataItem);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<MaterielModel> updateData(MaterielModel dataItem) async {
    Map<String, String> header = headers;

    var data = dataItem.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse("$mainUrl/materiels/update-materiel/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return MaterielModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse("$mainUrl/materiels/delete-materiel/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<List<PieChartEnguinModel>> getChartPie() async {
    Map<String, String> header = headers;

    var resp = await client.get(anguinsChartPieUrl, headers: header);
    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<PieChartEnguinModel> data = [];
      for (var row in bodyList) {
        data.add(PieChartEnguinModel.fromJson(row));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }
 
}
