import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:maslindapp/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:maslindapp/src/api/environment.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/services.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';


class ServicesProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/services';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Services>> getAll() async {
    try
    {
      Uri url = Uri.http(_url,'$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res =  await http.get(url, headers: headers);
      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion experida');
        new SharedPref().logout(context,sessionUser.id);
      }
      final data = json.decode(res.body);
      Services services = Services.fromJsonList(data);
      return services.toList;

    }
    catch(e)
    {
      print('Error: $e');
      return [];
    }
  }

}