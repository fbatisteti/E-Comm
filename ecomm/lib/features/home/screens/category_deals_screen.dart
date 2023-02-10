import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/common/widgets/stars.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/home/services/home_services.dart';
import 'package:ecomm/features/product_details/screens/product_details_screen.dart';
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

  double getRating(var rating) {
    double  totalRating = 0;
    for (int i = 0; i < rating!.length; i ++) {
      totalRating += rating![i].rating; // recebe todas as avaliações e soma
    }

    if (totalRating != 0) {
      totalRating = totalRating / rating!.length;
    }

    return totalRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),),
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
          Expanded(
            child: GridView.builder(
              itemCount: productList!.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // TLDR: preenche o máximo que dá
                crossAxisCount: ((MediaQuery.of(context).size.width)/150).floor(), // 1 para cada 150 pixels
                childAspectRatio: 0.75, // para não cobrir um aos outros
              ),
              itemBuilder: (context, index) {
                final product = productList![index];
                return GestureDetector(
                  onTap: () {Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);},
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 140,
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
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stars(rating: getRating(product.rating)),
                              Container(
                                alignment: Alignment.topLeft,
                                //padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                                child: Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}