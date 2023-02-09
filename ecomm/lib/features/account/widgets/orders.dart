import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/account/services/account_services.dart';
import 'package:ecomm/features/account/widgets/single_product.dart';
import 'package:ecomm/features/order_details/screens/order_details_screen.dart';
import 'package:ecomm/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({ Key? key }) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return (orders == null)
    ? const Loader()
    : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See all",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor
                ),
              ),
            ),
          ],
        ),
        // ORDERS
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => { Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orders![index]) },
                child: SingleProduct(image: orders![index].products[0].images[0])); // primeira imagem do primeiro produto
            },
          ),
        ),
      ],
    );
  }
}