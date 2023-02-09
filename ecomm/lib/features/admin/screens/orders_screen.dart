import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/features/account/widgets/single_product.dart';
import 'package:ecomm/features/admin/screens/add_products_screen.dart';
import 'package:ecomm/features/admin/services/admin_services.dart';
import 'package:ecomm/features/order_details/screens/order_details_screen.dart';
import 'package:ecomm/models/order.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({ Key? key }) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await adminServices.FetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (orders == null)
    ? const Loader()
    : GridView.builder(
      itemCount: orders!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // TLDR: preenche o máximo que dá
                  crossAxisCount: ((MediaQuery.of(context).size.width)/450).floor(), // 1 para cada 450 pixels
                  childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        final orderData = orders![index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orderData),
          child: SizedBox(
            height: 140,
            child: SingleProduct(image: orderData.products[0].images[0]),
          ),
        );
      },
    );
  }
}