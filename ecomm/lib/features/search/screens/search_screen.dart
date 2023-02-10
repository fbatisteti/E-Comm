import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/common/widgets/search_bar.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/home/widgets/address_box.dart';
import 'package:ecomm/features/product_details/screens/product_details_screen.dart';
import 'package:ecomm/features/search/services/search_services.dart';
import 'package:ecomm/features/search/widgets/searched_product.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProducts(context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(child: SearchBar(),),
      body: (products == null)
      ? const Loader()
      : Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10,),
          Expanded(
            child: (kIsWeb)
            ? GridView.builder( // muda a visualização se for para web, de lista para grid
                padding: const EdgeInsets.all(5),
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // TLDR: preenche o máximo que dá
                  crossAxisCount: ((MediaQuery.of(context).size.width)/450).floor(), // 1 para cada 450 pixels
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: products![index]);},
                  child: SearchedProduct(product: products![index])
                );
              }
              )
            : ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: products![index]);},
                  child: SearchedProduct(product: products![index])
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}