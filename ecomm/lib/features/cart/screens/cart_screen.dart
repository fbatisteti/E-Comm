import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/custom_button.dart';
import 'package:ecomm/common/widgets/search_bar.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/address/screens/address_screen.dart';
import 'package:ecomm/features/cart/widgets/cart_product.dart';
import 'package:ecomm/features/cart/widgets/cart_subtotal.dart';
import 'package:ecomm/features/home/widgets/address_box.dart';
import 'package:ecomm/features/search/screens/search_screen.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen(double sum) {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart.map((e) => sum += e['quantity']*e['product']['price'] as double).toList();
    
    return Scaffold(
      appBar: const CustomAppBar(child: SearchBar(),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomButton(
                text: 'Proceed to Buy (${user.cart.length} items)',
                onTap: () => navigateToAddressScreen(sum),
                color: Colors.yellow[600],  
              ),
            ),
            const SizedBox(height: 50,),
            Container(color: Colors.black12.withOpacity(0.08), height: 1,),
            const SizedBox(height: 5,),
            ListView.builder(
              itemCount: user.cart.length,  
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}