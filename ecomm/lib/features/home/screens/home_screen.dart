import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/search_bar.dart';
import 'package:ecomm/features/home/widgets/address_box.dart';
import 'package:ecomm/features/home/widgets/carousel_image.dart';
import 'package:ecomm/features/home/widgets/deal_of_the_day.dart';
import 'package:ecomm/features/home/widgets/top_categories.dart';
import 'package:ecomm/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(child: SearchBar(),),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 10,),
            TopCategories(),
            SizedBox(height: 10,),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
