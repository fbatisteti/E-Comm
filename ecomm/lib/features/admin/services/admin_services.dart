import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecomm/constants/error_handling.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/models/product.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import "package:ecomm/constants/private_variables.dart";
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdminServices {
  void SellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic(cloudinaryName, cloudinaryPreset);
      List<String> imageUrls = [];

      for (int i = 0; i<images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            kIsWeb ? images[i].path : images[i].path,
            folder: name // cada produto vai na sua pasta com seu nome
            )
          );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: product.toJson(),
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
          showSnackBar(context, 'Product added succesfully');
          Navigator.pop(context);
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
