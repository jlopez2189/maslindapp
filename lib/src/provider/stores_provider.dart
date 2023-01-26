import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maslindapp/src/api/environment.dart';
import 'package:maslindapp/src/models/response_api.dart';
import 'package:maslindapp/src/models/stores.dart';
import 'package:maslindapp/src/models/user.dart';
import 'package:maslindapp/src/utils/shared_pref.dart';

class StoresProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/stores';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Stores>> getAll() async {
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
      Stores stores = Stores.fromJsonList(data);
      return stores.toList;

    }
    catch(e)
    {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream> create(Stores stores, List<File> images) async {
    try
    {
      Uri url = Uri.http(_url,'$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser.sessionToken;
      for (int i = 0; i <images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));
      }

      request.fields['stores'] = json.encode(stores);
      final response =  await request.send(); // envio de peticion
      return response.stream.transform(utf8.decoder);
    }
    catch(e)
    {
      print('Error: $e');
      return null;
    }
  }
  }