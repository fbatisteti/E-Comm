import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/features/home/services/home_services.dart';
import 'package:ecomm/features/product_details/screens/product_details_screen.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({ Key? key }) : super(key: key);

  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Product? product;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product,);
  }

  @override
  Widget build(BuildContext context) {
    return (product == null)
    ? const Loader()
    : (product!.name == '')
    ? const SizedBox()
    : GestureDetector(
      onTap: navigateToDetailsScreen,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              'Deal of the Day',
              style: TextStyle(fontSize: 20),),
          ),
          Image.network(
            product!.images[0],
            height: 235,
            fit: BoxFit.contain,  
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15,),
            child: const Text(
              '\$100',
              style: TextStyle(fontSize: 18,),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              'Image',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images.map((e) => Image.network(
                  e,
                  fit: BoxFit.contain,
                  width: 100,
                  height: 100,
                ),
              ).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See all deals',
              style: TextStyle(color: Colors.cyan[800],),
            ),
          )
        ],
      ),
    );
  }
}