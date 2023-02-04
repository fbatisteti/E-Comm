import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({ Key? key }) : super(key: key);

  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the Day',
            style: TextStyle(fontSize: 20),),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1675154030133-10218759a22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8',
          height: 235,
          fit: BoxFit.fitHeight,  
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
            children: [
              Image.network('https://images.unsplash.com/photo-1675154030133-10218759a22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://images.unsplash.com/photo-1675154030133-10218759a22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://images.unsplash.com/photo-1675154030133-10218759a22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8', fit: BoxFit.fitWidth, width: 100, height: 100,),
              Image.network('https://images.unsplash.com/photo-1675154030133-10218759a22b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8', fit: BoxFit.fitWidth, width: 100, height: 100,),
            ],
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
    );
  }
}