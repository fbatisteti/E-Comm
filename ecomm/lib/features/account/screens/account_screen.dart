import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/generic_bar.dart';
import 'package:ecomm/features/account/widgets/below_appbar.dart';
import 'package:ecomm/features/account/widgets/orders.dart';
import 'package:ecomm/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
const AccountScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(child: GenericBar()),
      body: Column(
        children: const [
          BelowAppbar(),
          SizedBox(height: 10,),
          TopButtons(),
          SizedBox(height: 20,),
          Orders(),
        ],
      ),
    );
  }
}