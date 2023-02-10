import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/custom_button.dart';
import 'package:ecomm/common/widgets/search_bar.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/admin/services/admin_services.dart';
import 'package:ecomm/features/search/screens/search_screen.dart';
import 'package:ecomm/models/order.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    Key? key,
    required this.order
  }) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void changeOrderStatus() { // apenas admin
    adminServices.changeOrderStatus(
      context: context,
      status: widget.order.status + 1,
      order: widget.order,
      onSucces: () {
        setState(() {
          currentStep += 1;
        });
      }
    );
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: const CustomAppBar(child: SearchBar(),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("View order details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Order date:", style: TextStyle(fontWeight: FontWeight.w600),),
                            const Text("Order ID:", style: TextStyle(fontWeight: FontWeight.w600),),
                            const Text("Order total:", style: TextStyle(fontWeight: FontWeight.w600),),
                          ],
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))),
                            Text(widget.order.id),
                            Text("\$${widget.order.totalPrice}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),

              const Text("Purchase details", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Qty:${widget.order.quantity[i].toString()}",),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),

              const Text("Tracking", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Stepper(
                  controlsBuilder: ((context, details) {
                    return (user.type == 'admin')
                    ? CustomButton(text: 'Done', onTap: () => changeOrderStatus())
                    : const SizedBox(); // para não ter esse menu visível
                  }),
                  currentStep: currentStep,
                  steps: [
                    Step(
                      title: const Text("Pending"),
                      content: const Text("Your order is being proccessed"),
                      isActive: currentStep >= 0,
                      state: currentStep > 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Shipped"),
                      content: const Text("Your order has been shipped"),
                      isActive: currentStep >= 1,
                      state: currentStep > 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Delivered"),
                      content: const Text("Your order has been delivered"),
                      isActive: currentStep >= 2,
                      state: currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text("Finished"),
                      content: const Text("Delivery aknowledged"),
                      isActive: currentStep >= 3,
                      state: currentStep > 2 ? StepState.complete : StepState.indexed,
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}