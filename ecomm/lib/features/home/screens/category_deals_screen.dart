import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/home/services/home_services.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  _CategoryDealsScreenState createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    (widget.category == '')
    ? { productList = await homeServices.fetchNoCategoryProducts(context: context)  }
    : { productList = await homeServices.fetchCategoryProducts(context: context, category: widget.category) };

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container( // gambiarra para colocar um gradiente
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),),
        ),
      ),

      body: (productList == null)
      ? const Loader() // enquanto busca ou quando não tem nada
      : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: (widget.category == "")
            ? const Text('Browse all products', style: TextStyle(fontSize: 20),)
            : Text('Keep shopping for ${widget.category}', style: const TextStyle(fontSize: 20),),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              itemCount: productList!.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = productList![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 130,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.network(product.images[0]),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 0, top: 5, right: 15),
                      child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}