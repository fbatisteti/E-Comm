import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/features/account/services/account_services.dart';
import 'package:flutter/material.dart';

class GenericBar extends StatelessWidget {
  final bool isAdmin;
  final AccountServices accountServices = AccountServices();
  GenericBar({ Key? key, this.isAdmin = false }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: (isAdmin)
          ? const Text("Admin", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
          : Image.asset(
            'images/logo.png',
            width: 120,
            height: 45,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              IconButton(
                onPressed: () => showSnackBar(context, 'Alerts and push notifications not implemented'),
                icon: const Icon(Icons.notifications_outlined),
                tooltip: 'Alerts and push notifications not implemented',
              ),
              IconButton(
                onPressed: () => AccountServices().logOut(context),
                icon: const Icon(Icons.logout_outlined),
                tooltip: 'Log out',
              ),
            ],
          ),
        )
      ],
    );
  }
}