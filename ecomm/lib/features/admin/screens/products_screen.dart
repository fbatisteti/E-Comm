import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/features/account/widgets/single_product.dart';
import 'package:ecomm/features/admin/screens/add_products_screen.dart';
import 'package:ecomm/features/admin/services/admin_services.dart';
import 'package:ecomm/models/product.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({ Key? key }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final adminServices = AdminServices();
  List<Product>? products;

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductsScreen.routeName);
  }

  fetchAllProducts() async {
    products = await adminServices.FetchAllProducts(context);
    setState(() {});
  }

  deleteProduct(Product product, int index) {
    adminServices.DeleteProduct(
      context: context,
      product: product,
      onSucces: () {
        products!.removeAt(index);
        setState(() {});
      }
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
      ? const Loader() // enquanto busca ou quando não tem nada
      : Scaffold(
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // TLDR: preenche o máximo que dá
            crossAxisCount: ((MediaQuery.of(context).size.width)/150).floor(), // 1 para cada 150 pixels
            childAspectRatio: 0.75, // para não cobrir um aos outros
          ),
          itemBuilder: (context, index) {
            final productData = products![index];
            return Column(
              children: [
                SizedBox(
                  height: 140,
                  child: SingleProduct(image: productData.images[0]), // para mostrar só a primeira imagem do carrossel
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        productData.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ),
                    IconButton(
                      onPressed: () => deleteProduct(productData, index),
                      icon: const Icon(Icons.delete_outline, size: 18),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddProduct,
          tooltip: 'Add a product',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}