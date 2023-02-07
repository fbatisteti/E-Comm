import 'dart:convert';

import 'package:ecomm/constants/error_handling.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/models/product.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // porque está usando express
          'x-auth-token': userProvider.user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSucces: () {
          for(int i = 0; i<jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])) // transforma o índice i de JSON para um objeto, depois transforma em JSON, para criar um Product por meio dele
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }
}