import 'package:ecomm/features/account/services/account_services.dart';
import 'package:ecomm/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your orders',
              onTap: (){},
            ),

            AccountButton(
              text: 'Turn seller',
              onTap: (){},
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(
              text: 'Log out',
              onTap: () => AccountServices().logOut(context),
            ),

            AccountButton(
              text: 'Your wish list',
              onTap: (){},
            ),
          ],
        ),

      ],
    );
  }
}