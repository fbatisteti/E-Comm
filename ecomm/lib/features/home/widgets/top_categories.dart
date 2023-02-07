import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({ Key? key }) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName, arguments: category);
  }

  void navigateToAllCategoriesPage(BuildContext context) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName, arguments: '');
  }

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length + 1, // para ter a categoria para "tudo"
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () => navigateToAllCategoriesPage(context),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: const Icon(
                        Icons.all_inclusive_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                  const Text(
                    'Everything',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }

          return GestureDetector(
            onTap: () => navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index - 1]['image']!, // para compensar o +1 na contagem de itens
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index - 1]['title']!, // para compensar o +1 na contagem de itens
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}