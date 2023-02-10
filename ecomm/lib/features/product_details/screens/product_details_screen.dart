import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm/common/widgets/custom_app_bar.dart';
import 'package:ecomm/common/widgets/custom_button.dart';
import 'package:ecomm/common/widgets/search_bar.dart';
import 'package:ecomm/common/widgets/stars.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/features/product_details/services/product_details_services.dart';
import 'package:ecomm/features/search/screens/search_screen.dart';
import 'package:ecomm/models/product.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();

    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating +=
          widget.product.rating![i].rating; // recebe todas as avaliações e soma

      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        // e se for a avaliação do usuário, separa
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);

    showSnackBar(context, "Added 1x ${widget.product.name} to cart");
    showSnackBar(
        context, "Keep buying! You can change quantity during checkout");

    Navigator.pop(context);
  }

  void cantAddToCart() {
    showSnackBar(context, "Out of stock...");
  }

  void showRating() {
    String showRate = "Rated ${avgRating.toStringAsFixed(2)} out of 5";

    if (myRating > 0)
      showRate = "$showRate (you rated ${myRating.toStringAsFixed(2)})";

    showSnackBar(context, showRate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        child: SearchBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                  GestureDetector(
                    onTap: showRating,
                    child: Stars(rating: avgRating),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: "Deal price: ",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "\$${widget.product.price}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            (widget.product.quantity > 0)
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        text: "BUY NOW",
                        onTap: () {
                          showSnackBar(
                              context, "Instant purchase not implemented");
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        text: "BUY NOW",
                        color: Colors.grey,
                        onTap: cantAddToCart),
                  ),
            const SizedBox(
              height: 10,
            ),
            (widget.product.quantity > 0)
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        text: "ADD TO CART",
                        color: const Color.fromRGBO(254, 216, 19, 1),
                        onTap: addToCart),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        text: "OUT OF STOCK",
                        color: Colors.grey,
                        onTap: cantAddToCart),
                  ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
              allowHalfRating: true,
            ),
          ],
        ),
      ),
    );
  }
}
