import 'dart:convert';

import 'package:ecomm/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucces,
}) {
  switch(response.statusCode) {
    case 200:
      onSucces();
      break;

    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;

    default:
      showSnackBar(context, response.body);
      break;
  }
}
