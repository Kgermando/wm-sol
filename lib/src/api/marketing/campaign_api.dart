// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart'; 
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/models/marketing/campaign_model.dart';

class CampaignApi extends GetConnect {
  var client = http.Client();

  Future<List<CampaignModel>> getAllData() async {
    Map<String, String> header = headers;

    var resp = await client.get(campaignsUrl, headers: header);

    if (resp.statusCode == 200) {
      List<dynamic> bodyList = json.decode(resp.body);
      List<CampaignModel> data = [];
      for (var u in bodyList) {
        data.add(CampaignModel.fromJson(u));
      }
      return data;
    } else {
      throw Exception(jsonDecode(resp.body)['message']);
    }
  }

  Future<CampaignModel> getOneData(int id) async {
    Map<String, String> header = headers;

    var getUrl = Uri.parse("$mainUrl/campaigns/$id");
    var resp = await client.get(getUrl, headers: header);
    if (resp.statusCode == 200) {
      return CampaignModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CampaignModel> insertData(CampaignModel campaignModel) async {
    Map<String, String> header = headers;

    var data = campaignModel.toJson();
    var body = jsonEncode(data);

    var resp = await client.post(addCampaignsUrl, headers: header, body: body);
    if (resp.statusCode == 200) {
      return CampaignModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return insertData(campaignModel);
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<CampaignModel> updateData(CampaignModel campaignModel) async {
    Map<String, String> header = headers;

    var data = campaignModel.toJson();
    var body = jsonEncode(data);
    var updateUrl = Uri.parse("$mainUrl/campaigns/update-campaign/");

    var res = await client.put(updateUrl, headers: header, body: body);
    if (res.statusCode == 200) {
      return CampaignModel.fromJson(json.decode(res.body));
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }

  Future<void> deleteData(int id) async {
    Map<String, String> header = headers;

    var deleteUrl = Uri.parse("$mainUrl/campaigns/delete-campaign/$id");

    var res = await client.delete(deleteUrl, headers: header);
    if (res.statusCode == 200) {
    } else {
      throw Exception(json.decode(res.body)['message']);
    }
  }
}
